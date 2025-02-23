# Nix config

## Usage guide

1. Setup

Download this repo

Copy `.env.example` as `.env`

Fill in email & profile

Profile list
- `dororis`: darwin aarch64, work profile
- `oblivionis`: darwin aarch64, casual profile
- `mortis`: darwin x86_64, casual profile

Where main diff is, work profile not have karabiner, which usually banned from working machines

2. Init

```
# if darwin
make install_darwin

make install_nix
```

Then run

```
make setup
```

3. Build & apply flake

```
make build
make switch
```

4. Restart

Usually if you updated these things, you need to restart

- karabiner

For macos dock update, `killall Dock` to apply