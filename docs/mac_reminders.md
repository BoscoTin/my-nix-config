# Macos after setup

Many config not cover by nix (sigh) 

## System settings

- 24 hour clock
- Notification show preview
- Control center
    - sound / now playing not show
    - battery show percentage
- Wallpaper > Bigsur graphic

## Apps

<details>
  <summary>Google IME (Japanese)</summary>

  brew not working, nixpkgs has no suitable package. Install by your own.

  https://www.google.co.jp/ime/
</details>

<details>
  <summary>Open vanilla</summary>
  
    System settings > Input method > + > Openvanilla
</details>

<details>
  <summary>Docker</summary>

  Launcher > Open Docker app > accept
  Tune resource setting to lesser
</details>

<details>
  <summary>Shottr</summary>

  Settings > screenshot > keyboard shortcuts
  Turn off all screenshot shortcuts

  Then open shottr.app
  set command + shift + 3 > full area
  set command + shift + 4 > area screenshot
  set command + shift + 5 > scroll screenshot
</details>

<details>
  <summary>Karabiner</summary>

  Add extras/karabiner json to custom rules in Karabiner Elements

  For custom keyboard, switch the modifiers key one by one in karabiner elements > basic > devices > modifiers
  e.g. ikki-68, which in macos swap to macos config = [option, command, ctrl], in karabiner it need left-command -> left-option & left-option -> left-command
</details>

## Finder sidebar

Open finder > Move to ~/Users/user > File > Add to sidebar

Remove recents

## Terminal color profile

Terminal > Preferences > Profiles > Colors > Import... > `darwin/extras/Macchiato.terminal`

Change font after import: `MesloLGS...`

## Ensure user default shell is zsh

Some settings cannot be applied when default shell not zsh, can force change by

```chsh -s /etc/profiles/per-user/${}/bin/zsh```

Replace ${} with vars.username you set

---

### Unused

<details>
  <summary>Blackhole</summary>

    1. Install Blackhole audio plugin.

    2. Open audio midi app

    3. Make a new aggregate device

    4. Add blackhole input and your mic (let’s say your MacBook mic)

    5. Make a new multi output

    6. Add blackhole and your speaker (macs speaker)

    7. Quit the Audio MIDI app

    8. Cmd click on sound module in control center and change output and input to the new output and input we just made.
</details>