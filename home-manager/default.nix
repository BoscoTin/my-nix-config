{
  config,
  lib,
  pkgs,
  username,
  ...
}: 

{
  imports = [
    ./shell.nix
    ./git
    ./ssh.nix
    ./vscode.nix
  ];

  home.activation = {
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

  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "23.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}