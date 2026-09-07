{ ... }:

{
  # --- key remaps via hidutil (nix-darwin reapplies on login) ---------------
  #
  # HID usage code = 0x700000000 + keyboard usage id:
  #   0x39 Caps Lock     = 30064771129
  #   0x91 Lang2 / 英数  = 30064771217
  #   0xE0 Left Control  = 30064771296
  #   0xE2 Left Option   = 30064771298
  #   0xE3 Left Command  = 30064771299
  system.keyboard.enableKeyMapping = true;
  system.keyboard.userKeyMapping = [
    # Left Control <-> Left Command (replaces the karabiner simple_modifications
    # for the catch-all + built-in Apple keyboard)
    {
      HIDKeyboardModifierMappingSrc = 30064771296; # Left Control
      HIDKeyboardModifierMappingDst = 30064771299; # -> Left Command
    }
    {
      HIDKeyboardModifierMappingSrc = 30064771299; # Left Command
      HIDKeyboardModifierMappingDst = 30064771296; # -> Left Control
    }

    # Caps Lock -> 英数 (Eisu). macOS's Caps Lock language switch doesn't work
    # with Google Japanese IME, so route it to the Eisu key and let Google
    # IME's keymap do the mode toggle: Google Japanese IME > Preferences >
    # Keymap, bind Eisu to `ToggleAlphanumericMode` in the composition /
    # direct-input modes (one-time; the keymap is a binary config).
    # Trade-off: Caps Lock stops being a caps-lock key and there is no LED
    # feedback (that needed karabiner).
    {
      HIDKeyboardModifierMappingSrc = 30064771129; # Caps Lock
      HIDKeyboardModifierMappingDst = 30064771217; # -> Lang2 / 英数
    }
  ];

  # ikki-68 Left Command <-> Left Option: per-device, done in System Settings >
  # Keyboard > Modifier Keys with that board selected (keyed by USB id).
}
