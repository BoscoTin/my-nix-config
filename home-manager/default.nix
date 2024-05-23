{ username, ... }:

{
  imports = [
    ./zsh.nix
    ./git.nix
  ];

  home = {
    username = username;
    stateVersion = "23.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}