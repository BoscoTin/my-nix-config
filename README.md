# Nix config

## Usage guide

1. Init

Download this repo

```
make install_nix

make install_darwin
```


2. Setup

Copy `.env.example` as `.env`

Fill in email & profile

Profile list
- `dororis`: darwin aarch64, work profile
- `oblivionis`: darwin aarch64, casual profile
- `mortis`: darwin x86_64, casual profile

Where main diff is, work profile not have karabiner, which usually banned from working machines

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