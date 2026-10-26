# agenix-decrypted git profiles. Imported by profiles/base.nix.
#
# Per profile <name> (see my.git.mainProfile / my.git.includeProfiles):
#   git-<name>.identity.age   -> ~/.config/git/<name>.identity    main + included
#   git-<name>.conditions.age -> ~/.config/git/<name>.conditions  included only
#
# A host's main profile never decrypts its `.conditions`. Blobs missing from
# secrets/ are skipped, so a host builds before they are committed.
#
# Runtime prerequisite: the shared age key at ~/.config/agenix/key.txt
# (see secrets/README.md).
{
  config,
  inputs,
  lib,
  vars,
  ...
}:

let
  secretsDir = ../secrets;
  home = "/Users/${vars.username}";

  git = config.my.git;

  # agenix secret name -> decrypted path under $HOME
  gitFiles =
    lib.listToAttrs (
      map (name: {
        name = "git-${name}.identity";
        value = "${home}/.config/git/${name}.identity";
      }) ([ git.mainProfile ] ++ git.includeProfiles)
    )
    // lib.listToAttrs (
      map (name: {
        name = "git-${name}.conditions";
        value = "${home}/.config/git/${name}.conditions";
      }) git.includeProfiles
    );

  present = lib.filterAttrs (name: _: builtins.pathExists (secretsDir + "/${name}.age")) gitFiles;
in
{
  assertions = [
    {
      assertion = !(builtins.elem git.mainProfile git.includeProfiles);
      message = "my.git.includeProfiles must not contain my.git.mainProfile (${git.mainProfile}).";
    }
  ];

  imports = [ inputs.agenix.darwinModules.default ];

  age.identityPaths = [ "${home}/.config/agenix/key.txt" ];

  age.secrets = lib.mapAttrs (name: path: {
    file = secretsDir + "/${name}.age";
    inherit path;
    owner = vars.username;
    mode = "0600";
    symlink = false;
  }) present;
}
