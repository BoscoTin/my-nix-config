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
      prettylog = "log --pretty='%C(Yellow)%h    %C(reset)%ai%x09%C(Green)%an %C(Blue)(%ae)%C(reset): %s'  ";
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