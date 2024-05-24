{
  lib,
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
      ./users/w_sl_bitbucket.nix
    ];

    extraConfig = {
      push.autoSetupRemote = true;
      pull.rebase = true;
      core = {
        sshCommand = "ssh -i ~/.ssh/ps_github";
      };
    };
  };
}