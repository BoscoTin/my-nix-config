{ username, pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./git
    ./ssh.nix
    ./vscode.nix
  ];

  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "23.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}