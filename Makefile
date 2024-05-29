PROFILE=cerulean
EMAIL=boscotang98@gmail.com

init:
	ssh-keygen -t ed25519 -C "${EMAIL}" -f ~/.ssh/id_ed25519_personal

build:
	cp home-manager/git/users/notshown/ns_*.nix home-manager/git/users
	git add home-manager/git/users/*.nix
	nix build ".#darwinConfigurations.${PROFILE}.system" --extra-experimental-features "nix-command flakes"
	./result/sw/bin/darwin-rebuild switch --flake "$$(pwd)#${PROFILE}"
	rm home-manager/git/users/ns_*.nix