# Packages

Nix packages can be managed by these levels

1. Home manager (User package)

Usually having `programs.xxx`

Where installed packages will be symlinked to `/etc/profiles/per-user/${vars.username}/bin`

2. System config

For example, nix-darwin have some config related to os

Where installed packages will be symlinked to `/run/current-system/sw/bin`