# Nix config

## Workflow

Everyday changes go through the `justfile` (`just` + `nvd` are installed by the
config itself):

```
just build            # build every host's system closure — no activation
just diff oblivionis  # nvd diff of what `switch` would change vs the running system
just switch oblivionis # build both hosts, then activate this one (asks for sudo)
just rollback         # roll back to the previous generation if a switch goes bad
```

Always `just build` (both hosts) and `just diff` before `just switch`.

### Bootstrap (machine without `just` yet)

```
nix run .#just -- build
nix run .#just -- switch <host>   # first switch installs `just` + `nvd`
exec zsh                          # pick up the new PATH
```

`nix run .#just` uses the `just` pinned by this flake, so no prior install and no
registry dependency.

## Usage guide

1. Setup

Download this repo

Copy `.env.example` as `.env`

Fill in email & profile

Hosts (`hosts/<name>.nix`, each imports a `profiles/<profile>.nix`)
- `doloris`: aarch64-darwin, work profile
- `oblivionis`: aarch64-darwin, casual profile

Main diff: the work profile has no karabiner (banned on managed machines).

2. Init

```
# if darwin
make install_darwin

make install_nix
```

Then run

```
make setup
```

3. Build & apply flake

```
make build
make switch
```

4. Restart

Usually if you updated these things, you need to restart

- karabiner

For macos dock update, `killall Dock` to apply