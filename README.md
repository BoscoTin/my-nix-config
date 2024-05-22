## Reminder

1. When adding new files, make sure add to staging area before build

## Steps

1. Install Nix

```
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

2. Clone repository

```
nix run nixpkgs#git -- clone https://github.com/BoscoTin/my-nix-config.git
```

3. Build flake

```
nix build ".#darwinConfigurations.${PROFILE}.system" --extra-experimental-features "nix-command flakes"
```

4. darwin rebuild flake

```
./result/sw/bin/darwin-rebuild switch --flake "$$(pwd)#${PROFILE}"
```