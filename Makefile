include .env

define before_nix_build
	if [ -f ${GIT_SECRET_USERS_PATH}/*.nix ]; then \
		cp ${GIT_SECRET_USERS_PATH}/*.nix ${NIX_GIT_USERS_PATH}; \
		git add ${NIX_GIT_USERS_PATH}/*.nix; \
	fi
endef

define after_nix_build
	if [ -f ${NIX_GIT_USERS_PATH}/*.nix ]; then \
		rm ${NIX_GIT_USERS_PATH}/*.nix; \
	fi
endef

install_nix:
	curl -L https://nixos.org/nix/install) | sh

install_darwin:
	xcode-select --install
	softwareupdate --install-rosetta
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

setup:
	ssh-keygen -t ed25519 -C "${EMAIL}" -f ~/.ssh/id_ed25519_default

cleanup:
	$(after_nix_build)

build:
	$(before_nix_build)
	nix build ".#darwinConfigurations.${PROFILE}.system" --extra-experimental-features "nix-command flakes"
	$(after_nix_build)

switch:
	$(before_nix_build)
	./result/sw/bin/darwin-rebuild switch --flake "$$(pwd)#${PROFILE}"
	$(after_nix_build)

after_run:
	echo "For macOS system settings, please logout > login$'\n"
	echo "Copy below ssh public key to remote sites$'\n$$(cat ~/.ssh/id_ed25519_default.pub)$'\nhttps://github.com/settings/keys$'\nhttps://gitlab.com/-/profile/keys$'\nhttps://bitbucket.org/account/user/settings/ssh-keys/"