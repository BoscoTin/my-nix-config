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

## Homebrew casks removed from nix

`homebrew.onActivation.cleanup = "none"`, so dropping a cask from nix does not
uninstall it. After `just switch`, remove leftovers by hand:

- oblivionis: `brew uninstall --cask arc floorp` (replaced by Zen; export Arc
  bookmarks first, e.g. with `arc2zen`)
- doloris: `brew uninstall --cask arc` (replaced by Helium + Brave)

`just switch` also runs `brew update` and upgrades casks
(`homebrew.onActivation.autoUpdate/upgrade = true`), so claude-code and codex
stay current without a separate command.

## gluetun (Surfshark proxies, `my.roles.vpn`)

Nix provides the `~/.config/gluetun-stack` link to `config/gluetun/` (compose,
nginx, PAC; tracked) and `COMPOSE_PROFILES` (from `my.vpn.locations`), so each
host starts only its own locations.

- Confs are per device and never in the repo: a WireGuard server keeps one
  endpoint per key, so two devices sharing a conf make both stall. On each
  device, in Surfshark's manual setup (WireGuard, Static IP) generate a key
  pair for that device and location (a JP conf cannot be reused for Taiwan),
  download the `.conf`, then `just vpn-key <loc>` (reads the clipboard, or pass
  a path). Back the .conf up in the password manager. Locations per host:
  `my.vpn.locations` (casual tw + jp, work jp). A switch warns about locations
  without a conf; to replace a key, remove the old conf first.
- Docker Desktop must start at login (Settings > General > "Start Docker
  Desktop when you sign in"); containers use `restart: unless-stopped`.
- Start (new shell, so `COMPOSE_PROFILES` is set):
  `cd ~/.config/gluetun-stack && docker compose up -d`.
- Ports (all 127.0.0.1): HTTP proxy jp 18888; PAC jp 18889
  (`pac/jp-proxy.pac`); HTTP proxy tw 18891 (for Helium, all traffic).
- JP routing (manual, per Wi-Fi network): System Settings > Wi-Fi > Details...
  (on the connected network) > Proxies > turn on Automatic Proxy Configuration,
  URL `http://127.0.0.1:18889/jp-proxy.pac`. Only the PAC's domains use
  the proxy; with `gluetun-jp` stopped they fail instead of bypassing.
- Helium (all traffic via Taiwan, manual): install a proxy extension
  (FoxyProxy or SwitchyOmega), add an HTTP proxy `127.0.0.1` port `18891`, and
  keep it always on. Helium otherwise follows the macOS system proxy (the JP
  PAC). Verify with ipinfo.io (country TW). If `gluetun-tw` is down, pages
  fail instead of leaking.
- Proxy logs (`HTTPPROXY_LOG`) stay on; json-file rotation caps them at
  5 x 10 MB per container (Docker has no age-based retention).
- If `docker compose up -d` fails with "mountpoint ... is outside of rootfs"
  for `wg0.conf`, restart Docker Desktop and retry. Fallback: mount the conf
  with compose `secrets:` (`WIREGUARD_CONF_SECRETFILE=/run/secrets/wg0.conf`).
- Docker Desktop VM: raise Resources > Memory/Swap; a starved VM makes the
  proxy path stall while gluetun still reports healthy.

## Caps Lock → Google IME (romaji ⇄ alphanumeric) — unsolved

The old karabiner rule has no clean replacement:

- macOS's "Use Caps Lock to switch input source" **ignores Google Japanese IME**
  (Mozc reports ASCII-capable, so macOS sees it as Latin).
- Kotoeri (Apple's IME) works with it, but hard-binds `Ctrl`+digit for
  conversion — breaks `Ctrl+3` / `Ctrl+Shift+3` space switching in Arc/Zen.
- `hidutil` `Caps Lock → 英数` + Google IME keymap `Eisu → ToggleAlphanumericMode`
  works, but Caps Lock stops being a caps-lock key and there's no LED.

Currently: none adopted. The `Caps Lock → 英数` block is left commented in
`modules/darwin/system/keyboard.nix`; use the 英数 key by hand. To try the
hidutil route, uncomment that block, `just switch`, and set the Google IME
keymap. Google IME itself is a manual install — <https://www.google.co.jp/ime/>.

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

## Bitbucket SSH host migration (deadline 2026-11-12)

Bitbucket Cloud moves Git-over-SSH to `ssh.bitbucket.org`. The git module ships
an `insteadOf` rewrite so old-host remotes keep working after `just switch`.

1. Bulk-rewrite remotes with your own one-off script (not in the repo).
2. `just secret-edit git-local.age` / `git-work.age`: keep both
   `git@bitbucket.org:<org>/**` and `git@ssh.bitbucket.org:<org>/**` in the
   `hasconfig:remote.*.url:` conditions (`insteadOf` doesn't apply to them).
3. Host keys: not nix-managed (no `programs.ssh` yet). Connect once with
   `ssh -T git@ssh.bitbucket.org` and compare the fingerprint to Atlassian's
   published list before accepting.
4. Check by hand for hardcoded `bitbucket.org` in `~/.ssh/config`, `GOPRIVATE`,
   CI/Pipelines `known_hosts`, Helm/k8s, and pre-commit hooks.
5. Verify: `git ls-remote` in a migrated clone.
6. Once no old-host remotes remain, drop the `insteadOf` and the old-host
   condition patterns.
7. doloris: unprovisioned; run steps 1-3 there after provisioning, before
   its first `just switch`.

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
