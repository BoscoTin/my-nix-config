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

    userName = vars.gitUsername;
    userEmail = vars.useremail;

    includes = [] ++ lib.optionals (vars.isCasualProfile == true) [
      ./users/ns_work.nix
    ];

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