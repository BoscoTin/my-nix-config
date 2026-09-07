# Shared home-manager config for every host. Imported per-user by lib/mkHost.nix.
{
  vars,
  ...
}:

{
  home = {
    username = vars.username;
    homeDirectory = "/Users/${vars.username}";
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
      PATH = "$(go env GOPATH)/bin:$PATH";
    };
  };

  xdg.enable = true;

  # toggles for modules/**/hm-module.nix — see those for what each enables.
  # programs.go follows my.roles.go (wired in profiles/base.nix).
  programs = {
    git.enable = true;
    zsh.enable = true;
    direnv.enable = true;
    vscode.enable = true;
    ghostty.enable = true;
  };
}
