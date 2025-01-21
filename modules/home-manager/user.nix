{
  lib,
  pkgs,
  vars,
  ...
}:

{
  home = {
    username = vars.hmUsername;
    homeDirectory = "/Users/${vars.hmUsername}";
    stateVersion = "24.11";
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
      PATH = "$GOPATH/bin:$PATH";
    };
  };

  # todo: search on why cannot put in mortis
  xdg.enable = true;
  programs.ssh.enable = true;
}