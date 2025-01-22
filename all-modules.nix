{ lib }:

let
  enumerateModules =
    {
      prefix ? "",
      basePath,
    }:
    let
      isModule = n: lib.strings.hasSuffix "${prefix}module.nix" n;
    in
    lib.filter (isModule)
      (lib.filesystem.listFilesRecursive basePath);

  baseModules = enumerateModules {
    prefix = "base-";
    basePath = ./modules;
  };
in
{
  darwin = baseModules ++ 
    enumerateModules {
      prefix = "darwin-";
      basePath = ./modules;
    };
  nixos = baseModules ++
    enumerateModules {
      prefix = "nixos-";
      basePath = ./modules;
    };
  home = enumerateModules {
    prefix = "hm-";
    basePath = ./modules;
  };
}