{ pkgs, vars, ... }:
{
  system.stateVersion = 4; # keep unchanged

  services.karabiner-elements.enable = true;

  users.users = {
    ${vars.username} = {
      home = "/Users/${vars.username}";
      shell = pkgs.zsh;
    };  
  };

  networking = {
    hostName = "00-${vars.username}-${vars.deviceName}";
    localHostName = "00-${vars.hostProfile}-${vars.deviceName}";
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      meslo-lgs-nf
    ] ++ lib.optionals (vars.isCasualProfile == true) [
      source-code-pro
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
  };

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
      persistent-apps = if vars.isCasualProfile then [
        "/System/Applications/Launchpad.app/"
        "/Applications/Discord.app/"
        "/Applications/Telegram.app/"
        "/Applications/Signal.app/"
        "/System/Applications/Notes.app/"
        "/Applications/Arc.app/"
        "/Users/bosco/Applications/Home Manager Apps/Visual Studio Code.app"
      ] else [
        "/System/Applications/System Settings.app/"
        "/System/Applications/Launchpad.app/"
        "/System/Applications/Utilities/Terminal.app/"
        "/System/Applications/Notes.app/"
        "/Applications/Arc.app/"
        "/Users/bosco/Applications/Home Manager Apps/Visual Studio Code.app"
      ];
      persistent-others = [ "/Users/${vars.username}/Downloads" ];
    };

    NSGlobalDomain = {
      ApplePressAndHoldEnabled = false;
      InitialKeyRepeat = 25;
      KeyRepeat = 1;

      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;

      "com.apple.swipescrolldirection" = false;

      AppleInterfaceStyle = "Dark";
      AppleInterfaceStyleSwitchesAutomatically = false;
      AppleICUForce24HourTime = true;
    };

    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      ShowPathbar = true;
    };

    menuExtraClock = {
      # seems not working on macos sonoma
      Show24Hour = true;
      ShowAMPM = false;
      ShowDate = 1; # always
      ShowSeconds = true;
    };
  };
}