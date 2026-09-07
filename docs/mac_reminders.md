# macOS after setup

Steps not covered by nix.

## Now nix-managed (verify, don't redo)

- 24-hour clock — `modules/darwin/system/sys_defaults.nix`
- Control Center: sound / now-playing hidden, battery percentage —
  `modules/darwin/system/controlcenter.nix`
- Login shell zsh — `profiles/base.nix` (`environment.shells` + `users.users`)

Still manual:

- Notification: show preview
- Wallpaper > Big Sur graphic

## Caps Lock → Google IME (romaji ⇄ alphanumeric)

Replaces the old karabiner rule. The macOS "Use Caps Lock to switch input
source" toggle does **not** work with Google Japanese IME (macOS treats it as
Latin), so instead:

**nix (done)** — `modules/darwin/system/keyboard.nix` maps Caps Lock → 英数
(Lang2) via `system.keyboard.userKeyMapping`. Verify after a switch:
`hidutil property --get "UserKeyMapping"` shows `Src 30064771129 -> Dst 30064771217`.

**one-time manual:**

1. Enable "Japanese – Google" as an input source (System Settings > Keyboard >
   Input Sources > +). Google IME itself is a manual install (not in nixpkgs) —
   <https://www.google.co.jp/ime/>.
2. Google Japanese IME > Preferences > Keymap > Customize. Bind key `Eisu`
   (英数) to command `ToggleAlphanumericMode` for the Composition, Conversion
   and Precomposition/Direct modes. (Mozc's default MS-IME/Kotoeri preset may
   already give "Eisu → alphanumeric"; the custom `ToggleAlphanumericMode`
   binding is what makes it toggle back.) The keymap is a binary config, not
   nix-manageable.
3. Turn **off** the macOS "Use Caps Lock to switch…" toggle if you had enabled
   it — Caps Lock no longer reaches macOS as a caps-lock event, so it's inert.

Caveats: Caps Lock stops working as a caps-lock key; no LED feedback (that
needed karabiner).

## Modifier keys

- **Left Ctrl ⇄ Left Command** — nix, `keyboard.nix` (`userKeyMapping`).
  Verify: `hidutil property --get "UserKeyMapping"`.
- **ikki-68 Left Command ⇄ Left Option** — per-device: System Settings >
  Keyboard > Keyboard Shortcuts > Modifier Keys with that board selected.
  Keyed by USB vendor/product id, so not worth nix-ifying.

## Apps

<details>
  <summary>Google IME (Japanese)</summary>

  Not in nixpkgs / brew. Install manually: https://www.google.co.jp/ime/
</details>

<details>
  <summary>OpenVanilla</summary>

  System Settings > Keyboard > Input Sources > + > OpenVanilla
</details>

<details>
  <summary>Docker</summary>

  Launcher > open Docker app > accept. Tune resources down.
</details>

<details>
  <summary>Shottr</summary>

  Settings > Screenshot > keyboard shortcuts: turn off all macOS screenshot
  shortcuts, then in shottr.app set cmd+shift+3 full area, cmd+shift+4 area,
  cmd+shift+5 scroll.
</details>

## Finder sidebar

Finder > go to /Users/<user> > File > Add to Sidebar. Remove Recents.

---

### Unused

<details>
  <summary>Blackhole</summary>

  1. Install the Blackhole audio plugin.
  2. Open Audio MIDI Setup.
  3. New aggregate device: Blackhole + your mic.
  4. New multi-output: Blackhole + your speakers.
  5. Quit Audio MIDI Setup.
  6. Cmd-click the sound module in Control Center, pick the new I/O.
</details>
