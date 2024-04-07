.PHONY: all run update clean del_auto clean_all git

all: update run git clean 

run:
	nix run --log-format internal-json -v 2>&1 |nom --json

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
