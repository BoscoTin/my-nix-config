{
  osConfig,
  vars,
  ...
}:

let
  git = osConfig.my.git;
  gitDir = "~/.config/git";
in
{
  programs.git = {
    lfs.enable = true;

    # Main identity first, then each included profile's remote-URL conditions
    # (later wins). Files are decrypted by profiles/secrets.nix; git ignores
    # an include whose file is absent (un-provisioned host).
    includes =
      [ { path = "${gitDir}/${git.mainProfile}.identity"; } ]
      ++ map (name: { path = "${gitDir}/${name}.conditions"; }) git.includeProfiles;

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
        # fallback; the main profile identity overrides it
        sshCommand = "ssh -i ~/.ssh/id_ed25519_personal -o IdentitiesOnly=yes";
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