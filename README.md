# Nix Config

One flake for all my machines:

| Host     | What                   | Config                           |
| -------- | ---------------------- | -------------------------------- |
| `apollo` | MacBook Pro            | nix-darwin + home-manager        |
| `eos`    | M4 Mac mini            | nix-darwin + home-manager        |
| `eris`   | Oracle Cloud A1 server | NixOS + home-manager (fish only) |

- `home/` is shared by every machine (just fish); `home/darwin.nix` adds the Mac-only bits.
- Macs offload Linux builds to eris (`modules/darwin/builders.nix`).
- Homebrew uses `cleanup = "zap"`: anything not listed gets uninstalled on switch.

## Deploying

Push to `main`: [comin](https://github.com/nlewo/comin) on every machine pulls it and switches
within a minute. Push to `testing-<hostname>` to try something on one machine first.
`comin status` shows what each machine is running.

Inputs are bumped weekly by CI (`.github/workflows/update-flake-lock.yml`), which commits to
`main` only if every machine still evaluates.

Each machine needs a read-only GitHub token at `/etc/comin/github-token` (root, mode 600).

Manual escape hatches:

```sh
make switch   # the machine you're on, from the working tree
make eris     # evaluate here, build + activate on eris
make update   # bump flake inputs locally
```

`direnv allow` once to get nixfmt and the pre-commit hook; `nix fmt` formats everything.
