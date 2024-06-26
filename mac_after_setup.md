# Macos after setup

Many config not cover by nix (sigh) 

## System settings

- 24 hour clock
- Notification show preview
- Control center 
    - bluetooth show
    - sound / now playing not show
    - battery show percentage
- Wallpaper > Bigsur graphic

## Apps

<details>
  <summary>Open vanilla</summary>
  
    System settings > Input method > + > Openvanilla
</details>

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

<details>
  <summary>Docker</summary>

  Launcher > Open Docker app > accept
  Tune resource setting to lesser
</details>

## Finder sidebar

Open finder > Move to ~/Users/user > File > Add to sidebar

Remove recents

## Terminal color profile

Terminal > Preferences > Profiles > Colors > Import... > `darwin/extras/Macchiato.terminal`

Change font after import: `MesloLGS...`

## Ensure user default shell is zsh

Some settings cannot be applied when default shell not zsh, can force change by

```chsh -s /bin/zsh```