## Steps

1. Install Nix

```
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

2. Clone repository

```
nix run nixpkgs#git -- clone https://github.com/BoscoTin/my-nix-config.git
```