{ pkgs, username, ... }:
{
  users.users.${username} = {
    home = "/Users/${username}";
  };

  nix.settings.trusted-users = [username];

  fonts.fontDir = {
    enable = true;
  };
  fonts.fonts = with pkgs; [
    meslo-lgs-nf
    source-code-pro
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
}