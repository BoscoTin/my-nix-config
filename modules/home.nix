{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tmux
    wget
    terraform
    fcitx5-mozc
    vscode
    neovim
    ripgrep
    zip
    lz4
  ];

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    tmux = {
      enable = true;
      clock24 = true;
      enableMouse = true;
      enableVim = true;
    }
  };
}