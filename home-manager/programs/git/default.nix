{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {

  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = vars.username;
    userEmail = vars.useremail;

    includes = [] ++ lib.optionals (vars.isCasualProfile == true) [
      ./users/ns_work.nix
    ];

    ignores = [
      ".DS_Store"
    ];

    extraConfig = {
      push.autoSetupRemote = true;
      pull.rebase = true;

      core = {
        sshCommand = "ssh -i ~/.ssh/id_ed25519_default";
        editor = "vim";
      };
    };
  };
}