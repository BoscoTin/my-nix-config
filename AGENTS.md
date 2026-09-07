# AGENTS.md

Maintenance notes for this nix-darwin + home-manager config. Read `README.md`
first for the layout and workflow.

## Ground rules

- **Never `switch` without building both hosts.** `just build` (or
  `nix build .#darwinConfigurations.{oblivionis,doloris}.system`) must pass,
  and `nix flake check` must pass, before committing.
- **Check diffs with `nvd`.** `just diff <host>` (or
  `nvd diff /run/current-system ./result`). Every changed path should trace to
  a change you made. Unexplained churn = stop.
- **Don't activate the user's machine.** Build and eval only. The user runs
  `just switch`.
- **Commits:** karma style — `<type>(<scope>): <subject>`, imperative, one
  concern per commit. End the body with the `Co-Authored-By` trailer.
- **Stable channel is 26.05.** `nixpkgs`, `nix-darwin`, `home-manager` all
  `release-26.05`. Bump deliberately (`nix flake update`, test, then switch).
  For a package that needs to be newer, use `pkgs.unstable.<pkg>` (overlay in
  `modules/nix-core/overlay.nix`), not a channel bump.

## How things fit together

- `flake.nix` — inputs + `lib/mkHost.nix` builds each `darwinSystem` from
  `{ hostname, system }`. `checks.aarch64-darwin.*` = the host system
  closures. `packages.<sys>.just` = pinned `just` for `nix run .#just`.
- **Module discovery** — `all-modules.nix` globs `modules/` by filename
  suffix, no manual import list:
  - `*base-module.nix` → system (darwin) + carried into every eval
  - `*darwin-module.nix` → system (darwin) only
  - `*hm-module.nix` → home-manager
  Adding a file with one of those suffixes wires it in automatically.
- `modules/my/base-module.nix` — the `my.*` option namespace (system-level;
  hm modules read it via `osConfig.my.*`). Add options here as a consumer
  needs them.
- `profiles/` — `base.nix` (shared system + hm) is imported by `casual.nix`
  and `work.nix`, which set `my.profile`, `my.roles.*`, `my.git.includePath`.
  `profiles/secrets.nix` (agenix) is imported by `base.nix`.
- `hosts/<name>.nix` — thin: `imports = [ ../profiles/<p>.nix ]` plus
  machine-specific bits (dock, casks, `ids.gids.nixbld`).

## Common tasks

- **Add a CLI tool everywhere** → `modules/shells/syspkgs.nix` universal list.
- **Add a tool for one kind of machine** → put it in a `my.roles.<role>`
  bundle in `syspkgs.nix`, enable the role in the relevant profile. New role =
  add the `mkEnableOption` in `modules/my/base-module.nix`.
- **Add a home-manager program** → new `modules/<name>/hm-module.nix`, gate on
  `config.programs.<x>.enable` or a `my.*` toggle; flip it in `profiles/hm.nix`
  or a profile.
- **Add a host** → `hosts/<name>.nix` importing a profile + `mkHost` line in
  `flake.nix` + entry in `checks`.
- **Per-platform package** → explicit `lib.optionals
  pkgs.stdenv.hostPlatform.is<arch> [ … ]` in `syspkgs.nix` with a comment;
  don't rely on eval failing.

## Secrets (agenix)

- Single shared age key at `~/.config/agenix/key.txt`, backed up out of band.
  Recipient (public key) is in `secrets/secrets.nix`.
- `secrets/*.age` and `secrets/secrets.nix` are committed (encrypted /
  public); everything else in `secrets/` is gitignored.
- Edit: `just secret-edit <file>.age`. `profiles/secrets.nix` decrypts to
  `~/.config/git/{10-work,00-local}` at activation, gated on the blob
  existing (a host builds fine before blobs are committed).
- Git identity: base `[user]` is the personal identity on both hosts;
  `my.git.includePath` selects the include — casual `00-local` (work identity
  only for matching remotes), work `10-work` (work identity everywhere). The
  `sshCommand` paths in the config/blob are fixed (`~/.ssh/id_ed25519_default`,
  `~/.ssh/id_ed25519_sl`) — keep SSH key filenames consistent per device.

## Deliberately not nix-managed

macOS input sources, per-keyboard modifier maps, and the Caps Lock → Google
IME toggle — they don't survive OS upgrades declaratively. See
`docs/mac_reminders.md`. **Do not re-add karabiner** (managed work machines
block its DriverKit approval); `keyboard.nix` has the `hidutil` alternatives.
