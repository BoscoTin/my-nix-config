{
  config,
  lib,
  pkgs,
  username,
  useremail,
  ...
}: {
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

  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = username;
    userEmail = useremail;

    includes = [
      ./users/ns_work.nix
    ];

    extraConfig = {
      push.autoSetupRemote = true;
      pull.rebase = true;

      core = {
        sshCommand = "ssh -i ~/.ssh/id_ed25519_personal";
      };
    };
  };
}