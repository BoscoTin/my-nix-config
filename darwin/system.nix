{ pkgs, vars, ... }:
{
  users.users.${vars.username} = {
    home = "/Users/${vars.username}";
    shell = "${pkgs.zsh}/bin/zsh";
  };

  environment = {
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      neofetch
      go
      ripgrep
    ];
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

  system.stateVersion = 4;

  # mac osx settings
  security.pam.enableSudoTouchIdAuth = true;

  system.defaults = {
    dock = {
      autohide = false;
      tilesize = 20;
      magnification = true;
      largesize = 48;
      orientation = "bottom";
      mru-spaces = false;
      show-recents = false;
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
      persistent-others = [ "/Users/${vars.username}/Downloads" ];
    };

    NSGlobalDomain = {
      # fast key repeat in terminal
      ApplePressAndHoldEnabled = false;
      InitialKeyRepeat = 25;
      KeyRepeat = 1;

      # typing & spelling
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;

      # clock
      AppleICUForce24HourTime = true;
    };

    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      ShowPathbar = true;
    };

    menuExtraClock = {
      Show24Hour = true;
      ShowAMPM = false;
      ShowDate = 1; # always
      ShowSeconds = true;
    };
  };
}