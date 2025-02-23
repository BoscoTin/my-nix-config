{
  pkgs,
  vars,
  ...
}:

{
  users.users.${vars.username}.home = "/Users/${vars.username}";    
  networking = {
    hostName = "00-${vars.username}-${vars.device}";
    localHostName = "00-${vars.username}-${vars.device}";
  };

  fonts = {
    packages = with pkgs; [
      meslo-lgs-nf
      source-code-pro
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
  };

  nixpkgs.config.allowUnfree = true;
}