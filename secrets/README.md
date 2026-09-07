# secrets

Encrypted git identities, via [agenix](https://github.com/ryantm/agenix).
`secrets.nix` and `*.age` are committed (encrypted); everything else here is
gitignored.

## How it wires up

`profiles/secrets.nix` (imported by `profiles/base.nix`) decrypts blobs at
activation to `0600` files under `~/.config/git/`:

| blob | -> file | hosts |
|---|---|---|
| `git-work.age`  | `~/.config/git/10-work`  — `[user]` / `[core]` for work | every host |
| `git-local.age` | `~/.config/git/00-local` — `[includeIf ...]` dispatch   | casual only |

`modules/git/hm-module.nix` adds one `include.path`, set by
`my.git.includePath`:

- **casual** -> `00-local`: personal identity is the default; the work identity
  applies only to repos whose remote matches the `[includeIf]` condition.
- **work** -> `10-work`: every repo commits as the work identity, no personal
  default.

Git ignores the include when the file is absent (un-provisioned host).

## First-time setup (one machine)

```
mkdir -p ~/.config/agenix
age-keygen -o ~/.config/agenix/key.txt
age-keygen -y ~/.config/agenix/key.txt          # -> age1...
```

Put that `age1...` line into `secrets.nix` as `shared`. Back up
`~/.config/agenix/key.txt` (iCloud Drive with Advanced Data Protection, or a
USB copy) — losing it means re-encrypting every blob.

Create the blobs (`$EDITOR` opens on the decrypted content):

```
just secret-edit git-work.age
```

```
[user]
	name = <you>
	email = <you>@work.example
[core]
	sshCommand = ssh -i ~/.ssh/id_ed25519_work
```

```
just secret-edit git-local.age
```

```
[includeIf "hasconfig:remote.*.url:git@github.com:acme/**"]
	path = ~/.config/git/10-work
[includeIf "hasconfig:remote.*.url:git@bitbucket.org:acme/**"]
	path = ~/.config/git/10-work
```

The work machine only needs `git-work.age`; the casual machine needs both.

Then `git add secrets/*.age secrets/secrets.nix`, `just build`, `just switch`.

## Another machine

1. Copy `~/.config/agenix/key.txt` to it (AirDrop / iCloud Drive).
2. `just build && just switch <host>`.

The shared key means no per-device rekeying. To move to per-device keys later,
add each machine's recipient to `secrets.nix` and `agenix -r`.
