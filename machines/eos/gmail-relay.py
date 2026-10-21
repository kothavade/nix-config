"""Gmail push relay: Pub/Sub push -> Hermes webhook (stdlib only).

Google Pub/Sub can't HMAC-sign requests the way Hermes' webhook platform requires, so this sits
between them. Read-only: it never sends or changes mail.

  Pub/Sub --HTTPS POST /gmail/<url-token>--> relay (127.0.0.1:8645)
    1. checks the URL token, decodes {emailAddress, historyId}
    2. asks Gmail (history.list) what INBOX messages were added since the last historyId
    3. drops promos/social/forums and anything already seen
    4. POSTs the survivors to the Hermes webhook route, signed with that route's HMAC secret

Config (~/.hermes/gmail-relay.json, created by hand, not in the nix store):
  {"url_token": "...", "route": "gmail-triage",
   "accounts": {"you@gmail.com": "/Users/you/.hermes/google_token.json"}}
Each token file is an authorized-user JSON (client_id, client_secret, refresh_token). The route's
HMAC secret is read from ~/.hermes/webhook_subscriptions.json. State: ~/.hermes/gmail-relay-state.json.
"""

import base64
import hashlib
import hmac
import json
import os
import threading
import time
import urllib.parse
import urllib.request
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

HOME = os.path.expanduser("~/.hermes")
CONFIG = f"{HOME}/gmail-relay.json"
STATE = f"{HOME}/gmail-relay-state.json"
SUBS = f"{HOME}/webhook_subscriptions.json"
HERMES = "http://127.0.0.1:8644/webhooks/"
PORT = 8645
SKIP_LABELS = {"CATEGORY_PROMOTIONS", "CATEGORY_SOCIAL", "CATEGORY_FORUMS", "SPAM", "TRASH"}

lock = threading.Lock()
_access = {}  # token path -> (access_token, expiry)


def log(*a):
    print(time.strftime("%F %T"), *a, flush=True)


def load(path, default):
    try:
        with open(path) as f:
            return json.load(f)
    except FileNotFoundError:
        return default


def http(method, url, data=None, headers=None):
    req = urllib.request.Request(url, data=data, headers=headers or {}, method=method)
    with urllib.request.urlopen(req, timeout=20) as r:
        return json.loads(r.read() or b"{}")


def access_token(path):
    tok, exp = _access.get(path, (None, 0))
    if tok and exp > time.time() + 60:
        return tok
    c = load(path, {})
    r = http("POST", c.get("token_uri", "https://oauth2.googleapis.com/token"), urllib.parse.urlencode({
        "client_id": c["client_id"], "client_secret": c["client_secret"],
        "refresh_token": c["refresh_token"], "grant_type": "refresh_token"}).encode(),
        {"Content-Type": "application/x-www-form-urlencoded"})
    _access[path] = (r["access_token"], time.time() + r.get("expires_in", 3600))
    return r["access_token"]


def gmail(path, endpoint, **params):
    q = urllib.parse.urlencode(params, doseq=True)
    return http("GET", f"https://gmail.googleapis.com/gmail/v1/users/me/{endpoint}?{q}",
                headers={"Authorization": f"Bearer {access_token(path)}"})


def new_messages(path, email, history_id, state):
    """Messages added to INBOX since the last seen historyId, minus noise."""
    last = state.get(email)
    state[email] = max(int(history_id), int(last or 0))
    if not last:
        return []  # first notification: just record the baseline
    ids, page = [], None
    while True:
        params = dict(startHistoryId=last, historyTypes="messageAdded", labelId="INBOX", maxResults=100)
        if page:
            params["pageToken"] = page
        try:
            r = gmail(path, "history", **params)
        except urllib.error.HTTPError as e:
            if e.code == 404:  # history expired; reset the baseline
                return []
            raise
        for h in r.get("history", []):
            ids += [m["message"]["id"] for m in h.get("messagesAdded", [])]
        page = r.get("nextPageToken")
        if not page:
            break
    out = []
    for mid in dict.fromkeys(ids):
        m = gmail(path, f"messages/{mid}", format="metadata",
                  metadataHeaders=["From", "Subject", "Date"])
        labels = set(m.get("labelIds", []))
        if labels & SKIP_LABELS or "INBOX" not in labels or "SENT" in labels:
            continue
        h = {x["name"].lower(): x["value"] for x in m["payload"]["headers"]}
        out.append({"id": mid, "from": h.get("from", ""), "subject": h.get("subject", ""),
                    "date": h.get("date", ""), "labels": sorted(labels), "snippet": m.get("snippet", "")})
    return out


def forward(route, payload):
    secret = load(SUBS, {})[route]["secret"]
    body = json.dumps(payload).encode()
    ts = str(int(time.time()))
    sig = hmac.new(secret.encode(), ts.encode() + b"." + body, hashlib.sha256).hexdigest()
    http("POST", HERMES + route, body, {"Content-Type": "application/json", "X-Webhook-Signature-V2": sig,
                                        "X-Webhook-Timestamp": ts, "X-Request-ID": hashlib.sha1(body).hexdigest()})


class Handler(BaseHTTPRequestHandler):
    def log_message(self, *a):
        pass

    def reply(self, code):
        self.send_response(code)
        self.end_headers()

    def do_POST(self):
        cfg = load(CONFIG, {})
        want = "/gmail/" + cfg.get("url_token", "\0")
        if not hmac.compare_digest(self.path.encode(), want.encode()):
            return self.reply(404)
        try:
            body = json.loads(self.rfile.read(min(int(self.headers.get("Content-Length", 0)), 65536)))
            note = json.loads(base64.b64decode(body["message"]["data"]))
            email, hid = note["emailAddress"], note["historyId"]
            path = cfg["accounts"].get(email)
            if not path:
                log("unknown account", email)
                return self.reply(200)  # ack so Pub/Sub stops retrying
            with lock:
                state = load(STATE, {})
                msgs = new_messages(path, email, hid, state)
                if msgs:
                    forward(cfg["route"], {"account": email, "messages": msgs})
                with open(STATE, "w") as f:  # only after a successful forward, so failures retry
                    json.dump(state, f)
            log(email, "historyId", hid, "->", len(msgs), "message(s) forwarded")
            self.reply(200)
        except Exception as e:  # noqa: BLE001 - any failure -> 500 so Pub/Sub redelivers
            log("error", repr(e))
            self.reply(500)

    def do_GET(self):
        self.reply(200)  # health


if __name__ == "__main__":
    log("gmail relay listening on 127.0.0.1:%d" % PORT)
    ThreadingHTTPServer(("127.0.0.1", PORT), Handler).serve_forever()
