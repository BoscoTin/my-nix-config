{
  lib,
  pkgs,
  vars,
  ...
}: 

let
  inherit (builtins) readDir;

  inherit (lib)
    attrNames
    concatMap
    elemAt
    filter
    filterAttrs
    pathExists
    substring
    toLower
    foldl'
    ;
  inherit (lib.trivial) pipe;

  enumerateUsers =
    {
      prefix ? "",
      basePath,
    }:
    let
      childPaths = path: attrNames (filterAttrs (_: type: type == "directory") (readDir path));

      isShardedCorrectly = path: elemAt path 0 == toLower (substring 0 2 (elemAt path 1));

      mkPath = shard: package: [
        shard
        package
        "${prefix}.nix"
      ];

      modulesInShard = shard: map (mkPath shard) (childPaths (basePath + "/${shard}"));

      renderPath = foldl' (path: elem: path + "/${elem}");
    in
    pipe (childPaths basePath) [
      (concatMap modulesInShard)
      (filter isShardedCorrectly)
      (map (renderPath basePath))
      (filter pathExists)
    ];
in
{
  includedUsers = enumerateUsers {
    basePath = ./extra-users;
  };

  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = vars.defaultGitUsername;
    userEmail = vars.defaultGitMail;

    includes = includedUsers;

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