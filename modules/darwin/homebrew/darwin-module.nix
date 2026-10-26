{ lib, ... }:

{
  homebrew = {
    enable = true;

    # `switch` refreshes brew and upgrades casks (claude-code/codex don't self-update)
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "none";
    };

    # universal casks only; per-profile casks live in profiles/{casual,work}.nix
    casks = [
      "openvanilla"
      "shottr"
      "raycast"
      "docker-desktop"
      "helium-browser" # not `helium` (a different, disabled cask)
      "brave-browser"
      "claude" # desktop app (self-updating)
      "claude-code" # CLI
      "codex" # CLI; cask only (no formula)
      "ghostty" # nixpkgs ghostty is linux-only; app comes from here (see modules/terminal/ghostty)
    ];
  };
}