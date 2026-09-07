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

## Hosts

`hosts/<name>.nix`, each importing a `profiles/<profile>.nix`:

- `oblivionis`: aarch64-darwin, casual profile
- `doloris`: aarch64-darwin, work profile

Work profile has no karabiner (banned on managed machines) and commits every
repo as the work identity. Casual defaults to the personal identity and only
uses the work one for work repos. Both via agenix (see `secrets/README.md`).

## New machine

```
just install-nix
just install-darwin           # xcode CLT, rosetta, homebrew
just ssh-keygen you@example.com
# copy ~/.config/agenix/key.txt over (see secrets/README.md)
nix run .#just -- switch <host>
exec zsh
```

## After a switch

- system settings changes may need a logout/login
- dock changes: `killall Dock`
- `just rollback` reverts to the previous generation