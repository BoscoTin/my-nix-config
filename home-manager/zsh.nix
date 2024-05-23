{ pkgs, ...}:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      # make sure brew is on the path for aarch64-darwin
      if [[ $(uname -m) == 'arm64' ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
    '';
  };
}