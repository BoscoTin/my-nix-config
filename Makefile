PROFILE=cerulean
EMAIL=boscotang98@gmail.com

init:
	ssh-keygen -t ed25519 -C "${EMAIL}" -f ~/.ssh/id_ed25519_default

build:
	if [ -f home-manager/git/users/notshown/ns_*.nix ]; then \
	  cp home-manager/git/users/notshown/ns_*.nix home-manager/git/users; \
	  git add home-manager/git/users/*.nix; \
	fi
	nix build ".#darwinConfigurations.${PROFILE}.system" --extra-experimental-features "nix-command flakes"
	./result/sw/bin/darwin-rebuild switch --flake "$$(pwd)#${PROFILE}"
	rm home-manager/git/users/ns_*.nix

after_run:
	echo "Copy below ssh public key to remote sites$'\n$$(cat ~/.ssh/id_ed25519_default.pub)$'\nhttps://github.com/settings/keys$'\nhttps://gitlab.com/-/profile/keys$'\nhttps://bitbucket.org/account/user/settings/ssh-keys/"