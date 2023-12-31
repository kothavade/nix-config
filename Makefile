.PHONY: update run clean

run r:
	nix run

update u:
	nix flake update

clean c:
	nix-collect-garbage --delete-old
	sudo nix-collect-garbage --delete-old
