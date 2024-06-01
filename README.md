# Nix config

Curreny available on macos (aarch64-darwin / x86_64-darwin)

## Structure

`darwin` contains config from `nix-darwin`, refer to https://daiderd.com/nix-darwin/manual/index.html

`home-manager` contains config from `home-manager`, refer to https://home-manager-options.extranix.com

## Guide

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

### Macos

1. Terminal color profile

Terminal > Preferences > Profiles > Colors > Import... > `darwin/extras/Mocha.terminal`

2. Openvanilla

System settings > Input method > + > Openvanilla

## Problems on macos / nix-darwin?

1. Need to restart every time when system defaults change

2. if not add following paths, shell does not work with system packages / user packages

System package path: `/run/current-system/sw/bin`

User package path: `/etc/profiles/per-user/${vars.username}/bin`

Refer to zsh.nix `initExtra` for setup