{
  lib,
  pkgs,
  vars,
  ...
}: 

{
  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = vars.defaultGitUsername;
    userEmail = vars.defaultGitMail;

    includes = lib.filter (lib.strings.hasSuffix ".nix") (lib.filesystem.listFilesRecursive ./extra-users);

    ignores = [
      ".DS_Store"
    ];

    aliases = {
      prettylog = "log --pretty=format:'%C(Yellow)%h%x09%Creset%ai%x09%Cgreen%an %Cblue(%ae)%Creset: %s'";
      undo = "reset --soft HEAD^";
      cancel = "reset --hard HEAD^";
      onemore = "commit -a --amend --no-edit";
    };

    # pager
    delta = {
      enable = true;
      options = {
        side-by-side = true;
        navigate = true;
      };
    };

    extraConfig = {
      push.autoSetupRemote = true;
      pull.rebase = false;

      core = {
        sshCommand = "ssh -i ~/.ssh/id_ed25519_default";
        editor = "vim";
      };
    };
  };
}