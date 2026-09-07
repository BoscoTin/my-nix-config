# Nix config

nix-darwin + home-manager, release 26.05. Apple Silicon.

## Workflow

`just` + `nvd` are installed by the config itself.

```
just build             # build every host's system closure — no activation
just diff <host>       # nvd diff of what a switch would change
just switch <host>     # build both hosts, then activate <host> (asks for sudo)
just rollback          # back to the previous generation
just --list            # everything else (update, gc, secret-edit, ...)
```

Always `just build` + `just diff` before `just switch`. For risky changes see
`docs/switch-test.md`.

### Bootstrap (no `just` yet)

```
nix run .#just -- build
nix run .#just -- switch <host>     # first switch installs just + nvd
exec zsh
```

`nix run .#just` uses the `just` pinned by this flake — no prior install.

## Layout

```
flake.nix            inputs + mkHost
lib/mkHost.nix       builds a darwinSystem from { hostname, system }
modules/             auto-discovered by filename suffix (all-modules.nix):
                       *base-module.nix   -> system + home
                       *darwin-module.nix -> system (darwin)
                       *hm-module.nix     -> home-manager
modules/my/          the `my.*` option namespace
profiles/            base.nix + casual.nix / work.nix — where toggles are set
hosts/<name>.nix     thin: imports a profile + machine specifics
secrets/             agenix (see secrets/README.md)
```

## Hosts & profiles

| host | arch | profile | roles | karabiner | git identity |
|---|---|---|---|---|---|
| `oblivionis` | aarch64-darwin | casual | kubernetes, cloud, node, go | (removed) | personal; work identity for work repos |
| `doloris` | aarch64-darwin | work | kubernetes, cloud, node, go | never | work identity everywhere |

Roles (`my.roles.*` in the profile) gate package bundles in
`modules/shells/syspkgs.nix`. Flip one per profile or per host and
`just diff` shows exactly what changes.

## New machine

```
just install-nix
just install-darwin              # xcode CLT, rosetta, homebrew
just ssh-keygen you@example.com
# copy ~/.config/agenix/key.txt over  (secrets/README.md)
nix run .#just -- switch <host>
exec zsh
```

Manual macOS bits that nix can't reach: `docs/mac_reminders.md`.

## After a switch

- `system.defaults` changes may need `killall SystemUIServer ControlCenter Dock` or a logout
- `just rollback` reverts to the previous generation (homebrew changes are not reverted)
