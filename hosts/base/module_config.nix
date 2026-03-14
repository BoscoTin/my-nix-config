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
      nerd-fonts.fira-code
      nerd-fonts.symbols-only
    ];
  };

  nixpkgs.config.allowUnfree = true;
}