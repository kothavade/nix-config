.PHONY: update run clean all

run:
	nix run

update:
	nix flake update

clean:
	nix-collect-garbage --delete-old
	sudo nix-collect-garbage --delete-old

all: update run clean
