# Switch-test problems

You tested the **Phase 3** build (`avplgj9…-25.11`). Phases 4–7 are already
committed on this branch — several of these are fixed by moving to the current
HEAD (`nix run .#just -- switch oblivionis`, the 26.05 build).

---

## 1. macchiato config in ghostty not found

Cause: Phase 3 still had `programs.ghostty.package = pkgs.emptyDirectory`, so
home-manager did not reliably write `~/.config/ghostty/config`.

Fixed in Phase 5 (`26d077d`): `package = null`. HEAD build writes the config —
verified it contains `theme = catppuccin-macchiato`, `font-family = MesloLGS NF`,
opacity/blur/scrollback.

Then a second cause: the theme name. Ghostty reads the nix config fine
(`ghostty +show-config` showed `theme = catppuccin-macchiato`) but has no
theme by that slug — its bundled Catppuccin theme is titled
`Catppuccin Macchiato`, so it silently fell back to the default.

Fixed in `8c215f3`: `theme = "Catppuccin Macchiato"`.

Action: `nix run .#just -- switch oblivionis` again, restart ghostty.
Verify: `ghostty +show-config | grep theme` -> `Catppuccin Macchiato`.

Status: **fixed; re-switch to apply.**

## 2. $GHOSTTY_RESOURCES_DIR empty string

Not a real bug. That variable is exported by the **ghostty app itself**, only
inside a ghostty window — it is empty in any other terminal.

On Phase 3, `enableZshIntegration` + `emptyDirectory` also injected a broken
`source /nix/store/…-empty-directory/…` line into `.zshrc`. HEAD (package =
null) injects no such line; ghostty's automatic shell integration sets the
variable when you launch the app.

Action: after switching to HEAD, open ghostty and run `echo $GHOSTTY_RESOURCES_DIR`
*inside that window* — should be `/Applications/Ghostty.app/Contents/Resources/ghostty`.

Status: **fixed at HEAD; verify inside a ghostty window.**

## 3. karabiner test both failed (docs/karabiner_*.txt)

`launchctl list` showed `karabiner_grabber` and `karabiner_observer` with pid
`-` (not running) and `activate_karabiner_system_ext` `-`. The 14.13.0 overlay
pin never actually worked under nix-darwin — the grabber (the part that does
the remapping) doesn't start. This matches the original "karabiner broken"
report.

Fixed in Phase 7 (`9a898bc`): karabiner removed entirely. At HEAD,
`launchctl list | grep karabiner` is empty and nothing references it.

Action: switch to HEAD; confirm no karabiner launch agents. Then set the IME /
modifier keys natively (see #5). Optionally delete
`/Applications/Karabiner-Elements.app`.

Status: **fixed at HEAD.**

## 4. system config not verifiable (already had 24h / battery %)

The declarations are in the config:

- 24h clock — `system.defaults.NSGlobalDomain.AppleICUForce24HourTime`,
  `system.defaults.menuExtraClock.Show24Hour` (`modules/darwin/system/sys_defaults.nix`)
- battery % — `system.defaults.controlcenter.BatteryShowPercentage`
  (`modules/darwin/system/controlcenter.nix`, Phase 7 only)

You can't verify reproducibility without resetting the prefs. If you want
certainty, on the HEAD build:

```bash
defaults -currentHost read com.apple.controlcenter BatteryShowPercentage   # -> 1
defaults delete com.apple.menuextra.clock 2>/dev/null; killall SystemUIServer
nix run .#just -- switch oblivionis        # nix should set the clock back to 24h
```

Status: **declared; real repro test deferred to a fresh install or the reset
above.**

## 5. Caps Lock / modifier keys work — should they be in config?

Yes. You set them by hand; capture them so a new machine reproduces them.

```bash
# Caps Lock -> Google IME switch
defaults read com.apple.HIToolbox > /tmp/hitoolbox.txt

# modifier remap (ctrl <-> cmd etc.), per keyboard
defaults -currentHost read -g com.apple.keyboard.modifiermapping 2>/dev/null
defaults read com.apple.keyboard.modifiermapping 2>/dev/null
```

Findings so far:

- `defaults -currentHost read com.apple.HIToolbox` -> "does not exist".
- `defaults read com.apple.HIToolbox` -> only `ABC` enabled; Google IME and
  OpenVanilla are only in `AppleInputSourceHistory`, not
  `AppleEnabledInputSources`. No caps-lock-switch flag present.

Decisions:

- **Caps Lock → Google IME**: stays a manual System Settings step. Enabling a
  third-party input source and its caps-lock toggle doesn't survive macOS
  upgrades declaratively, and Google IME itself isn't nix-installable. Do it in
  System Settings > Keyboard > Input Sources.
- **Left Ctrl ↔ Left Command** (built-in keyboard): now nix, via
  `system.keyboard.userKeyMapping` in `keyboard.nix` (from the archived
  `karabiner.json`). Verify: `hidutil property --get "UserKeyMapping"`.
- **ikki-68 Left Command ↔ Left Option**: per-device, System Settings >
  Keyboard > Modifier Keys with that board selected (keyed by USB id, not
  worth nix-ifying).

Status: **ctrl/cmd swap in nix; IME + per-device swap are manual by choice.**

## 6. rollback target different

Not a failure — you are still on the refactor build, you have not rolled back.

- `~/rollback-target.txt` = `g4bbak52…` — the pre-refactor `experiment` build
- `/run/current-system` = `avplgj9…` — the Phase 3 refactor build you switched to

So the mismatch is the *expected* "you are on the new build" signal. Choose:

```bash
# forward to the finished build (fixes 1-3):
nix run .#just -- switch oblivionis

# OR back to experiment:
sudo darwin-rebuild --list-generations        # find the one that is g4bbak52
sudo darwin-rebuild --rollback                # -> previous generation
diff <(readlink -f /run/current-system) ~/rollback-target.txt   # now matches
```

If `--rollback` doesn't land on `g4bbak52`, activate it explicitly:
`sudo /nix/var/nix/profiles/system-<N>-link/activate`.

Status: **expected behaviour; pick forward or back.**
