.PHONY: switch eris update clean

OS := $(shell uname)
HOST := $(shell hostname -s)

# Switch whichever machine this is run on, from the working tree.
switch:
ifeq ($(OS), Darwin)
	sudo darwin-rebuild switch --flake .#$(HOST)
else
	sudo nixos-rebuild switch --flake .#$(HOST)
endif

# Evaluate here, build and activate on eris.
eris:
	nix run nixpkgs#nixos-rebuild-ng -- switch --flake .#eris --target-host eris --build-host eris --sudo

update:
	nix flake update


clean:
	sudo nix-collect-garbage --delete-old
