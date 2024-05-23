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

    includes = [];

    extraConfig = {
      push.autoSetupRemote = true;
      pull.rebase = true;
    };

    
  };
}