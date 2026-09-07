# Removing the leftover karabiner install

Phase 7 removed karabiner from the nix config, but that only stops nix from
*managing* it. The already-installed launchd jobs, plist files, app bundle and
DriverKit system extension stay until you tear them down.

## Step 1 — reboot, then re-check

The `karabiner_console_user_server` / `session_monitor` jobs are loaded into
your current login session; a reboot drops anything not re-loaded from disk.

```bash
launchctl list | grep -i karabiner
sudo launchctl list | grep -i karabiner
```

If both are empty now, you're done. Optional tidy-up:

```bash
sudo rm -rf /Applications/Karabiner-Elements.app \
            "/Applications/.Karabiner-VirtualHIDDevice-Manager.app"
rm -rf ~/.config/karabiner ~/.local/share/karabiner
```

## Step 2 — if it survives the reboot

Inventory what's still there:

```bash
ls -la ~/Library/LaunchAgents/ | grep -iE 'karabiner|pqrs'
ls -la /Library/LaunchAgents/ /Library/LaunchDaemons/ | grep -iE 'karabiner|pqrs|nixos'
systemextensionsctl list | grep -i -A1 karabiner
ls -d ~/.config/karabiner "/Library/Application Support/org.pqrs" 2>/dev/null
```

Unload running jobs (use the exact labels from `launchctl list`):

```bash
uid=$(id -u)
for l in \
  org.pqrs.karabiner.karabiner_console_user_server \
  org.pqrs.karabiner.karabiner_session_monitor \
  org.pqrs.karabiner.agent.karabiner_grabber \
  org.pqrs.karabiner.agent.karabiner_observer \
  org.nixos.activate_karabiner_system_ext ; do
  launchctl bootout gui/$uid/$l 2>/dev/null
done
sudo launchctl bootout system/org.pqrs.Karabiner-DriverKit-VirtualHIDDeviceClient 2>/dev/null
```

Deactivate the DriverKit extension (needs the manager app, before deleting it):

```bash
"/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager" deactivate
```

Remove the files:

```bash
rm -f  ~/Library/LaunchAgents/org.pqrs.karabiner.*.plist
sudo rm -f  /Library/LaunchDaemons/org.pqrs.*.plist /Library/LaunchAgents/org.pqrs.*.plist
sudo rm -rf "/Library/Application Support/org.pqrs"
sudo rm -rf /Applications/Karabiner-Elements.app "/Applications/.Karabiner-VirtualHIDDevice-Manager.app"
rm -rf ~/.config/karabiner ~/.local/share/karabiner
```

Then **reboot once more** and confirm `systemextensionsctl list` and
`launchctl list | grep karabiner` are clean.

## Replacement mappings (now in nix)

`modules/darwin/system/keyboard.nix`:

- Left Control ↔ Left Command swap — `system.keyboard.userKeyMapping` (global,
  covers the built-in keyboard). Verify after switch:
  `hidutil property --get "UserKeyMapping"`
- ikki-68 (Left Command ↔ Left Option): per-device, do it in System Settings >
  Keyboard > Modifier Keys with that board selected.
- Caps Lock → Google IME: capture procedure in the same file / `mac_reminders.md`.
