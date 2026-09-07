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

## Caps Lock → Google IME (かな ⇄ alphanumeric)

Replaces the old karabiner rule. See `modules/darwin/system/keyboard.nix`.

1. System Settings > Keyboard > Input Sources > Edit… > enable
   "Use the Caps Lock key to switch to and from <Japanese – Google>".
2. Capture the plist delta and paste it into `keyboard.nix`:
   ```
   defaults read com.apple.HIToolbox > /tmp/hit.before
   # toggle the setting
   defaults read com.apple.HIToolbox > /tmp/hit.after
   diff /tmp/hit.before /tmp/hit.after
   ```
3. Google IME > Preferences > Keymap: bind Caps Lock / 英数 to
   "Set input mode to alphanumeric" and かな to "Set input mode to Hiragana"
   (binary config, can't be nix-managed).

## Modifier keys (ctrl ⇄ cmd, etc.)

System Settings > Keyboard > Keyboard Shortcuts > Modifier Keys, per keyboard.
For a custom board (e.g. ikki-68) swap the modifiers one by one.

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
