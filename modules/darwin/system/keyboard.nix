{ ... }:

{
  # --- modifier remaps (replaces the karabiner simple_modifications) ---------
  #
  # Karabiner swapped Left Control <-> Left Command on the catch-all + the
  # built-in Apple keyboard. hidutil does the same globally, reapplied on
  # login by nix-darwin. HID usage = 0x700000000 + keyboard usage id:
  #   0xE0 Left Control  = 30064771296
  #   0xE2 Left Option   = 30064771298
  #   0xE3 Left Command  = 30064771299
  system.keyboard.enableKeyMapping = true;
  system.keyboard.userKeyMapping = [
    {
      HIDKeyboardModifierMappingSrc = 30064771296; # Left Control
      HIDKeyboardModifierMappingDst = 30064771299; # -> Left Command
    }
    {
      HIDKeyboardModifierMappingSrc = 30064771299; # Left Command
      HIDKeyboardModifierMappingDst = 30064771296; # -> Left Control
    }
  ];

  # Per-device swaps (ikki-68 Left Command <-> Left Option) and the
  # Caps Lock -> Google IME かな/alphanumeric toggle are done in System
  # Settings by hand — macOS input sources and per-keyboard modifier maps
  # don't survive OS upgrades declaratively. See docs/mac_reminders.md.
}
