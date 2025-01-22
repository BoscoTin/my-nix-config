# Nix config

Curreny available on macos (aarch64-darwin / x86_64-darwin)

## Structure

`darwin` contains config from `nix-darwin`, refer to https://daiderd.com/nix-darwin/manual/index.html

`home-manager` contains config from `home-manager`, refer to https://home-manager-options.extranix.com

## Macos pre-requisite

### Google IME

brew not working, nixpkgs has no suitable package.

https://www.google.co.jp/ime/

## Guide

1. Init

Download this repo

```
make install_nix

make install_darwin
```


2. Setup

```
make setup $EMAIL
```

3. Build & apply flake

```
make build
make switch $NIX_PROFILE
```

## After setup (optional)

```
make after_run
```

### Macos

Refer to [here](mac_after_setup.md)

## Problems on macos / nix-darwin?

1. Need to restart every time when system defaults change

2. if not add following paths, shell does not work with system packages / user packages

System package path: `/run/current-system/sw/bin`

User package path: `/etc/profiles/per-user/${vars.username}/bin`

Refer to zsh.nix `initExtra` for setup