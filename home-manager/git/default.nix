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
      ./users/ps_github.nix
      ./users/ps_gitlab.nix
    ];

    extraConfig = {
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
  };
}