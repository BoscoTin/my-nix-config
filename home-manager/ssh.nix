{ ... }:

{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      AddKeysToAgent yes
      UseKeychain yes
      IdentitiesOnly yes
    '';
  };
}