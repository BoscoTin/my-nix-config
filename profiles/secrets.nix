# agenix-decrypted git identities. Imported by profiles/base.nix.
#
#   git-work.age  -> ~/.config/git/10-work   [user]/[core] for work   (every host)
#   git-local.age -> ~/.config/git/00-local  [includeIf] dispatch     (casual only)
#
# Casual includes 00-local (personal default, work identity only for work
# repos). Work includes 10-work directly (see my.git.includePath).
#
# Runtime prerequisite: the shared age key at ~/.config/agenix/key.txt
# (see secrets/README.md). Blobs are picked up once committed as secrets/*.age.
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

  # agenix secret name -> decrypted path under $HOME
  gitIdentity =
    { "git-work" = "${home}/.config/git/10-work"; }
    // lib.optionalAttrs (config.my.profile != "work") {
      "git-local" = "${home}/.config/git/00-local";
    };

  present = lib.filterAttrs (name: _: builtins.pathExists (secretsDir + "/${name}.age")) gitIdentity;
in
{
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
