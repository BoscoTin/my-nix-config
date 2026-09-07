{ ... }:

{
  # --- key remaps via hidutil (nix-darwin reapplies on login) ---------------
  #
  # HID usage code = 0x700000000 + keyboard usage id:
  #   0x39 Caps Lock     = 30064771129
  #   0x91 Lang2 / 英数  = 30064771217
  #   0xE0 Left Control  = 30064771296
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

    # Caps Lock -> 英数 for Google IME toggling. Disabled while testing native
    # macOS input-switch behaviour. To re-enable, uncomment:
    # {
    #   HIDKeyboardModifierMappingSrc = 30064771129; # Caps Lock
    #   HIDKeyboardModifierMappingDst = 30064771217; # -> Lang2 / 英数
    # }
  ];

  # ikki-68 Left Command <-> Left Option: per-device, done in System Settings >
  # Keyboard > Modifier Keys with that board selected (keyed by USB id).
}
