.PHONY: all run update clean

all: update run clean

run:
	nix run

update:
	nix flake update

clean:
	nix-collect-garbage --delete-old
	sudo nix-collect-garbage --delete-old

