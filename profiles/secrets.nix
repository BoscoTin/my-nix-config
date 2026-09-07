# agenix-decrypted git identities. Imported only by profiles that need them
# (currently work). Casual hosts never load agenix.
#
# Runtime prerequisite: the shared age key at ~/.config/agenix/key.txt
# (see secrets/README.md). Blobs are picked up once committed as secrets/*.age.
{
  inputs,
  lib,
  vars,
  ...
}:

let
  secretsDir = ../secrets;
  home = "/Users/${vars.username}";

  # agenix secret name -> decrypted path under $HOME
  gitIdentity = {
    "git-local" = "${home}/.config/git/00-local";
    "git-work" = "${home}/.config/git/10-work";
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
