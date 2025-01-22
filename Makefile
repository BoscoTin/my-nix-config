PROFILE=mortis
EMAIL=boscotang98@gmail.com

install_nix:
	sh <(curl -L https://nixos.org/nix/install)

install_darwin:
	xcode-select --install
	softwareupdate --install-rosetta
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

setup:
	ssh-keygen -t ed25519 -C "${EMAIL}" -f ~/.ssh/id_ed25519_default

build:
	nix build ".#darwinConfigurations.${PROFILE}.system" --extra-experimental-features "nix-command flakes"

switch:
	./result/sw/bin/darwin-rebuild switch --flake "$$(pwd)#${PROFILE}"

after_run:
	echo "For macOS system settings, please logout > login$'\n"
	echo "Copy below ssh public key to remote sites$'\n$$(cat ~/.ssh/id_ed25519_default.pub)$'\nhttps://github.com/settings/keys$'\nhttps://gitlab.com/-/profile/keys$'\nhttps://bitbucket.org/account/user/settings/ssh-keys/"