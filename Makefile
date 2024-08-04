.PHONY: update
update: 
	home-manager switch --flake .#home
clean:
	nix-collect-garbage -d
