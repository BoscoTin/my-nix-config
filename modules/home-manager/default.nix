{
  config,
  lib,
  pkgs,
  vars,
  ...
}: 

{
  imports = [
    ./programs/git
    ./programs/direnv.nix
    ./programs/ssh.nix
    ./programs/vscode.nix
    ./programs/zoxide.nix
    ./programs/zsh.nix
    ./programs/k9s.nix
  ];

  home = {
    username = vars.username;
    homeDirectory = "/Users/${vars.username}";
    stateVersion = "24.05";
    sessionPath = [
      "$HOME/.local/bin"
      "/usr/local/bin"
      "/run/current-system/sw/bin"
      "/etc/profiles/per-user/${vars.username}/bin"
    ];
    sessionVariables = {
      # enable scrolling in git diff
      DELTA_PAGER = "less -R --mouse";
      TERM = "xterm-256color";
    };
  };

  xdg.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}