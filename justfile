# my-nix-config workflow — see README "Workflow".
# Bootstrap on a machine without `just`:  nix run .#just -- build

hosts := "oblivionis doloris"

# list recipes
default:
    @just --list

# build every host's system closure (no activation) — the preflight gate
build:
    #!/usr/bin/env bash
    set -euo pipefail
    for h in {{ hosts }}; do
      echo "==> $h"
      nix build --no-link --print-out-paths ".#darwinConfigurations.$h.system"
    done

# preview what `switch HOST` would change vs the running system
diff host="oblivionis":
    #!/usr/bin/env bash
    set -euo pipefail
    nix build -o result ".#darwinConfigurations.{{ host }}.system"
    if command -v nvd >/dev/null; then
      nvd diff /run/current-system result
    else
      nix run nixpkgs#nvd -- diff /run/current-system result
    fi

# diff a committed git REF's build against the working tree, for HOST
diff-refs ref host="oblivionis":
    #!/usr/bin/env bash
    set -euo pipefail
    wt="$(mktemp -d)/wt"
    git worktree add "$wt" "{{ ref }}"
    trap 'git worktree remove --force "$wt"' EXIT
    nix build "$wt#darwinConfigurations.{{ host }}.system" -o result-ref
    nix build ".#darwinConfigurations.{{ host }}.system" -o result-wt
    if command -v nvd >/dev/null; then
      nvd diff result-ref result-wt
    else
      nix run nixpkgs#nvd -- diff result-ref result-wt
    fi

# build both hosts, then activate HOST (prompts for sudo)
switch host: build
    sudo darwin-rebuild switch --flake ".#{{ host }}"

# evaluate + build all flake checks
check:
    nix flake check

# update every flake input
update:
    nix flake update

# update a single flake input, e.g. `just update-input nixpkgs`
update-input input:
    nix flake update {{ input }}

# roll the running system back to the previous generation
rollback:
    sudo darwin-rebuild --rollback

# list system generations
generations:
    darwin-rebuild --list-generations

# collect garbage older than 30d, then optimise the store
gc:
    sudo nix-collect-garbage --delete-older-than 30d
    nix store optimise

# install this device's Surfshark WireGuard conf for a location, e.g. `just vpn-key jp` (from the clipboard) or `just vpn-key jp ./jp.conf`
vpn-key loc src="":
    #!/usr/bin/env bash
    set -euo pipefail
    dir="$HOME/.config/gluetun/wireguard"
    dest="$dir/{{ loc }}.conf"
    [[ -w "$dir" ]] || { echo "$dir is not writable: just switch first" >&2; exit 1; }
    [[ ! -e "$dest" ]] || { echo "$dest exists: remove it first to replace the key" >&2; exit 1; }
    tmp="$(mktemp)"
    trap 'rm -f "$tmp"' EXIT
    if [[ -n "{{ src }}" ]]; then cat "{{ src }}" > "$tmp"; else pbpaste > "$tmp"; fi
    grep -q '^\[Interface\]' "$tmp" && grep -q '^PrivateKey' "$tmp" && grep -q '^\[Peer\]' "$tmp" \
      || { echo "input is not a WireGuard .conf" >&2; exit 1; }
    install -m 0600 "$tmp" "$dest"
    echo "installed $dest; start it with: cd ~/.config/gluetun-stack && docker compose up -d"

# --- secrets (agenix) -------------------------------------------------------

# edit an encrypted blob, e.g. `just secret-edit git-work.age`
secret-edit file:
    cd secrets && agenix -e {{ file }} -i ~/.config/agenix/key.txt

# print this machine's age recipient line for secrets/secrets.nix
age-recipient:
    @age-keygen -y ~/.config/agenix/key.txt

# --- one-time machine bootstrap ------------------------------------------------

# xcode CLT, rosetta, homebrew
install-darwin:
    xcode-select --install || true
    softwareupdate --install-rosetta --agree-to-license
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install nix
install-nix:
    sh <(curl -L https://nixos.org/nix/install)

# generate this device's ssh key for a git profile, e.g. `just ssh-keygen personal`
ssh-keygen name:
    ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_{{ name }}

# print a profile's ssh public key, e.g. `just ssh-pubkey personal`
ssh-pubkey name:
    @cat ~/.ssh/id_ed25519_{{ name }}.pub
