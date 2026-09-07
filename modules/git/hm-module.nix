{
  osConfig,
  vars,
  ...
}:

{
  programs.git = {
    lfs.enable = true;

    # identity entry point — decrypted by profiles/secrets.nix, absent (and
    # silently ignored by git) on un-provisioned hosts. See my.git.includePath.
    includes = [ { path = osConfig.my.git.includePath; } ];

    ignores = [
      ".DS_Store"
    ];

    settings = {
      user.name = vars.defaultGitUsername;
      user.email = vars.defaultGitMail;

      # [alias] — `aliases` (plural) writes [aliases], which git ignores
      alias = {
        prettylog = "log --pretty=format:'%C(Yellow)%h%x09%Creset%ai%x09%Cgreen%an %Cblue(%ae)%Creset: %s'";
        undo = "reset --soft HEAD^";
        cancel = "reset --hard HEAD^";
        onemore = "commit -a --amend --no-edit";
      };

      push.autoSetupRemote = true;
      pull.rebase = false;

      core = {
        sshCommand = "ssh -i ~/.ssh/id_ed25519_default";
        editor = "vim";
      };
    };
  };

  # pager
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      side-by-side = true;
      navigate = true;
    };
  };
}