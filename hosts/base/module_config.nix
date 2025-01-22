{
  pkgs,
  vars,
  ...
}:

{
  users.users.${vars.username}.home = "/Users/${vars.username}";    
  networking = {
    hostName = "00-${vars.username}";
    localHostName = "00-${vars.username}";
  };

  nixpkgs.config.allowUnfree = true;
}