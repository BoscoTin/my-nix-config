{
  pkgs,
  vars,
  ...
}:

{
  system.defaults.menuExtraClock = {
    # seems not working on macos sonoma
    Show24Hour = true;
    ShowAMPM = false;
    ShowDate = 1; # always
    ShowSeconds = true;
  };

  system.defaults.NSGlobalDomain = {
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
}