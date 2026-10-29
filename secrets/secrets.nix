# Recipients for each secret. Secrets are encrypted only to the host keys of the machines that
# use them; decryption happens there at activation (agenix), with /etc/ssh/ssh_host_ed25519_key.
# Nothing else can decrypt them, including us: to change one, re-encrypt its full new value
# with ./encrypt. Add a machine's key with `ssh <host> cat /etc/ssh/ssh_host_ed25519_key.pub`.
let
  eos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJlIHtYlBNlgGsAv3tG5Nv8JQ1FNCNf1xaIrFPh0tQOu";
in
{
}
