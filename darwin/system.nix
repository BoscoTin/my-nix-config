{ pkgs, vars, ... }:
{
  users.users.${vars.username} = {
    home = "/Users/${vars.username}";
    shell = "${pkgs.zsh}/bin/zsh";
  };

  networking.hostName = "00-${vars.username}-${vars.deviceName}";
  networking.localHostName = "00-${vars.hostProfile}-${vars.deviceName}";

  environment = {
    shells = with pkgs; [ zsh ];
    # ensure add path in shell
    # https://github.com/LnL7/nix-darwin/issues/922
    systemPackages = with pkgs; [
      neofetch
      go
      ripgrep
      eza

      hoppscotch
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
        "/Applications/Signal.app/"
        "/System/Applications/Notes.app/"
        "/Applications/Arc.app/"
        "/Users/bosco/Applications/Home Manager Apps/Visual Studio Code.app"
        "/run/current-system/Applications/Hoppscotch.app"
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
      # seems not working on macos sonoma
      Show24Hour = true;
      ShowAMPM = false;
      ShowDate = 1; # always
      ShowSeconds = true;
    };
  };
}