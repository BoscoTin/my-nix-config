{ pkgs, vars, ... }:
{
  users.users.${vars.username} = {
    home = "/Users/${vars.username}";
    shell = "${pkgs.zsh}/bin/zsh";
  };

  environment.variables.SHELL = "${pkgs.zsh}/bin/zsh";

  nix.settings.trusted-users = [vars.username];

  fonts.fontDir = {
    enable = true;
  };
  fonts.fonts = with pkgs; [
    meslo-lgs-nf
    source-code-pro
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
}