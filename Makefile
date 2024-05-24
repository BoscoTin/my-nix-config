PROFILE=cerulean

build:
	nix build ".#darwinConfigurations.${PROFILE}.system" --extra-experimental-features "nix-command flakes"
	./result/sw/bin/darwin-rebuild switch --flake "$$(pwd)#${PROFILE}"