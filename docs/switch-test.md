# Testing a switch safely

Generic checklist for any risky change (channel bump, big refactor, new module).
Everyday small changes just need `just diff` → `just switch`.

## 1. Record the rollback target

```bash
git status                                       # clean, on the branch you're testing
readlink -f /run/current-system | tee ~/rollback-target.txt
sudo darwin-rebuild --list-generations | tail -3
```

`darwin-rebuild --rollback` restores this exact generation regardless of which
branch is checked out — it's a re-activation, not a rebuild.

## 2. Build + preview

```bash
nix run .#just -- build                           # every host must build
nix run .#just -- diff <host>                      # nvd diff vs the running system
```

Read the diff. Every line should trace to a change you made — package
add/remove, version bump from a channel change, a renamed store path. Stop if
something unexplained shows up.

## 3. Switch + confirm

```bash
nix run .#just -- switch <host>
exec zsh
nix build --no-link --print-out-paths .#darwinConfigurations.<host>.system
readlink -f /run/current-system                    # equal to the line above; differs from ~/rollback-target.txt
```

## 4. Smoke checks

- new shell: prompt renders, no errors printed at startup
- `command -v` the tools you expect; the ones you removed are gone
- git identity in a repo (`git config user.email`), aliases work
- GUI apps you touched (ghostty, vscode) launch with the expected config
- anything the change specifically added — check it directly, don't assume
- `system.defaults` changes: may need `killall SystemUIServer ControlCenter Dock`
  or a logout to show

## 5. Rollback

```bash
sudo darwin-rebuild --rollback
exec zsh
diff <(readlink -f /run/current-system) ~/rollback-target.txt && echo "restored"
```

Notes:
- Homebrew changes are **not** reverted by rollback.
- If you switched more than once, `--rollback` only steps back one — use the
  explicit generation: `sudo /nix/var/nix/profiles/system-<N>-link/activate`.
- The branch and its commits are untouched; `just switch` goes forward again.
