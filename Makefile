.PHONY: all switch update clean del_auto clean_all git

all: update switch git clean 

OS := $(shell uname)

switch:
ifeq ($(OS), Darwin)
	darwin-rebuild switch --flake .
else ifeq ($(OS), Linux)
	sudo nixos-rebuild switch --flake .
endif

update:
	nix flake update

clean:
	nix-collect-garbage --delete-old
	sudo nix-collect-garbage --delete-old

del_auto:
	sudo rm /nix/var/gcroots/auto/*

clean_all: clean del_auto

git:
	git add .
	git commit -m "update"
	git push
