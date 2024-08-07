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
  ];

  home = {
    username = vars.username;
    homeDirectory = "/Users/${vars.username}";
    stateVersion = "24.05";
    # if problem occurs, run rm -rf /Applications/Home Manager Trampolines
    activation = {
      # https://github.com/LnL7/nix-darwin/issues/214#issuecomment-2050027696
      # nix-darwin does not create sym-links for home-manager installed apps
      rsync-home-manager-applications = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        rsyncArgs="--archive --checksum --chmod=-w --copy-unsafe-links --delete"
        apps_source="$genProfilePath/home-path/Applications"
        moniker="Home Manager Trampolines"
        app_target_base="${config.home.homeDirectory}/Applications"
        app_target="$app_target_base/$moniker"
        mkdir -p "$app_target"
        ${pkgs.rsync}/bin/rsync $rsyncArgs "$apps_source/" "$app_target"
      '';
    };
    sessionPath = [
      "$HOME/.local/bin"
      "/usr/local/bin"
      "/run/current-system/sw/bin"
      "/etc/profiles/per-user/${vars.username}/bin"
    ];
    sessionVariables = {
      # enable scrolling in git diff
      DELTA_PAGER = "less -R --mouse";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}