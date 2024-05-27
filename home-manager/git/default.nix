{
  config,
  lib,
  pkgs,
  username,
  useremail,
  ...
}: {

  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = username;
    userEmail = useremail;

    includes = [
      ./users/ns_work.nix
    ];

    ignores = [
      ".DS_Store"
    ];

    extraConfig = {
      push.autoSetupRemote = true;
      pull.rebase = true;

      core = {
        sshCommand = "ssh -i ~/.ssh/id_ed25519_personal";
        editor = "vim";
      };
    };
  };
}