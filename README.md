## Reminder

1. When adding new files, make sure add to staging area before build

## Steps

1. Init

- install nix
- install homebrew
- clone this config repo

```
sh <(curl -L https://nixos.org/nix/install)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
nix run nixpkgs#git --extra-experimental-features "nix-command flakes" -- clone https://github.com/BoscoTin/my-nix-config.git
```

2. setup required files

```
make init
```

3. Build & apply flake

```
make build
```

## After setup (optional)

```
make after_run
```

1. Macos Terminal color profile

Terminal > Preferences > Profiles > Colors > Import... > `darwin/extras/Mocha.terminal`

2. Macos add input method

System settings > Input method > + > Openvanilla