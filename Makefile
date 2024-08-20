PROFILE=cerulean
EMAIL=boscotang98@gmail.com

init:
	ssh-keygen -t ed25519 -C "${EMAIL}" -f ~/.ssh/id_ed25519_default

build:
	if [ -f modules/home-manager/programs/git/users/notshown/ns_*.nix ]; then \
	  	cp modules/home-manager/programs/git/users/notshown/ns_*.nix modules/home-manager/programs/git/users; \
	 	git add modules/home-manager/programs/git/users/*.nix; \
	fi
	nix build ".#darwinConfigurations.${PROFILE}.system" --extra-experimental-features "nix-command flakes"
	./result/sw/bin/darwin-rebuild switch --flake "$$(pwd)#${PROFILE}"
	if [ -f modules/home-manager/programs/git/users/notshown/ns_*.nix ]; then \
		rm modules/home-manager/programs/git/users/ns_*.nix; \
	fi

after_run:
	echo "For macOS system settings, please logout > login$'\n"
	echo "Copy below ssh public key to remote sites$'\n$$(cat ~/.ssh/id_ed25519_default.pub)$'\nhttps://github.com/settings/keys$'\nhttps://gitlab.com/-/profile/keys$'\nhttps://bitbucket.org/account/user/settings/ssh-keys/"