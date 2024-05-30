{ pkgs, vars, ... }:
{
  users.users.${vars.username} = {
    home = "/Users/${vars.username}";
    shell = "${pkgs.zsh}/bin/zsh";
  };

  environment = {
    shells = with pkgs; [ zsh ];
  };

  nix.settings.trusted-users = [vars.username];

  fonts.fontDir = {
    enable = true;
  };
  fonts.fonts = with pkgs; [
    meslo-lgs-nf
    source-code-pro
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  system.defaults = {
    dock = {
      autohide = false;
      tilesize = 20;
      magnification = true;
      largesize = 48;
      orientation = "bottom";
      persistent-apps = [
        "/System/Applications/Launchpad.app/"
        "/Applications/Discord.app/"
        "/Applications/Telegram.app/"
        "/Applications/Anytype.app/"
        "/System/Applications/Notes.app/"
        "/Applications/Firefox.app/"
        "/Applications/Arc.app/"
        "/Applications/Brave Browser.app/"
        "/Users/bosco/Applications/Home Manager Apps/Visual Studio Code.app"
      ];
      persistent-others = [ "~/Downloads" ];
    };
  };
}