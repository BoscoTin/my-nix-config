{ pkgs, vars, ... }:
{

  # mac osx settings
  security.pam.enableSudoTouchIdAuth = true;

  system.defaults = {
    dock = {
      autohide = false;
      tilesize = 20;
      magnification = true;
      largesize = 48;
      orientation = if vars.isCasualProfile then "bottom" else "right";
      mru-spaces = false;
      show-recents = false;
      persistent-apps = if vars.isCasualProfile then [
        "/System/Applications/Launchpad.app/"
        "/Applications/Discord.app/"
        "/Applications/Telegram.app/"
        "/Applications/Signal.app/"
        "/System/Applications/Notes.app/"
        "/Applications/Arc.app/"
        "/Users/${vars.username}/Applications/Home Manager Apps/Visual Studio Code.app"
      ] else [
        "/System/Applications/System Settings.app/"
        "/System/Applications/Launchpad.app/"
        "/System/Applications/Utilities/Terminal.app/"
        "/System/Applications/Notes.app/"
        "/Applications/Arc.app/"
        "/Users/${vars.username}/Applications/Home Manager Apps/Visual Studio Code.app"
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