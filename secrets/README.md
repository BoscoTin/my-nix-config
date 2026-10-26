# secrets

Encrypted git identities, via [agenix](https://github.com/ryantm/agenix).
`secrets.nix` and `*.age` are committed (encrypted); everything else here is
gitignored.

## How it wires up

Git identities are **named profiles** (`personal`, plus one per organization). Each host
picks a main profile and a list of included ones in `profiles/<name>.nix`
(`my.git.mainProfile`, `my.git.includeProfiles`):

| host | main | included |
|---|---|---|
| casual (oblivionis) | `personal`       | `<organization>` |
| work (doloris)      | `<organization>` | `personal`       |

Per profile `<name>`, `profiles/secrets.nix` decrypts to `0600` files under
`~/.config/git/` at activation:

| blob | -> file | decrypted on |
|---|---|---|
| `git-<name>.identity.age`   | `<name>.identity` — `[user]`, `core.sshCommand` | main + included |
| `git-<name>.conditions.age` | `<name>.conditions` — `[includeIf]` stanzas      | included only |

`modules/git/hm-module.nix` includes `<main>.identity` unconditionally, then
each included profile's `.conditions` (later wins), so matching repos switch
identity. A main profile's `.conditions` is never decrypted or included.
Git ignores includes whose file is absent (un-provisioned host).

A new organization is a new profile name in the `profileType` enum
(`modules/my/base-module.nix`), its blobs, and a key.

## SSH keys

One key per device per profile, generated on that device and never copied
(nix only references the path, never the key):

```
just ssh-keygen personal          # -> ~/.ssh/id_ed25519_personal
just ssh-keygen <organization>    # -> ~/.ssh/id_ed25519_<organization>
just ssh-pubkey <organization>    # register on that org's GitHub/Bitbucket
```

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
just secret-edit git-personal.identity.age
just secret-edit git-<organization>.identity.age
```

```
[user]
	name = <you>
	email = <you>@example.com
[core]
	sshCommand = ssh -i ~/.ssh/id_ed25519_<profile> -o IdentitiesOnly=yes
```

```
just secret-edit git-<organization>.conditions.age
just secret-edit git-personal.conditions.age
```

Each conditions blob has one stanza per remote pattern of that profile:

`hasconfig` matches the raw remote URL (`insteadOf` does not apply), so use
the new Bitbucket SSH host:

```
[includeIf "hasconfig:remote.*.url:git@github.com:acme/**"]
	path = ~/.config/git/<organization>.identity
[includeIf "hasconfig:remote.*.url:git@ssh.bitbucket.org:acme/**"]
	path = ~/.config/git/<organization>.identity
```

`personal.conditions` is the same shape with your own account, pointing at
`~/.config/git/personal.identity`:

```
[includeIf "hasconfig:remote.*.url:git@github.com:<your-user>/**"]
	path = ~/.config/git/personal.identity
```

A host needs the identity blob of its main profile plus identity and
conditions blobs of each included profile.

Then `git add secrets/*.age secrets/secrets.nix`, `just build`, `just switch`.

## Another machine

1. Copy `~/.config/agenix/key.txt` to it (AirDrop / iCloud Drive).
2. `just build && just switch <host>`.

The shared key means no per-device rekeying. To move to per-device keys later,
add each machine's recipient to `secrets.nix` and `agenix -r`.
