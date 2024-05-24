{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    initExtraBeforeCompInit = ''
      # p10k instant prompt
      P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
      [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
    '';
    initExtra = ''
      # make sure brew is on the path for aarch64-darwin
      if [[ $(uname -m) == 'arm64' ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
      eval "$(ssh-agent -s)"
    '';

    oh-my-zsh = {
      enable = true;
    };

    plugins = with pkgs; [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "p10k-config";
        src = ./p10k;
        file = "p10k.zsh";
      }
      {
        name = "zsh-cat-syntax";
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "zsh-syntax-highlighting";
          rev = "06d519c20798f0ebe275fc3a8101841faaeee8ea";
          sha256 = "sha256-Q7KmwUd9fblprL55W0Sf4g7lRcemnhjh4/v+TacJSfo=";
        };
        file = "themes/cappuchin_mocha-zsh-syntax-highlighting.zsh";
      }
    ];
  };
}