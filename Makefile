.PHONY: switch eris update upgrade clean

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

# Upgrade every Homebrew cask, including self-updating ones; .pkg casks prompt for sudo.
upgrade:
	brew update && brew upgrade --greedy

clean:
	sudo nix-collect-garbage --delete-old
