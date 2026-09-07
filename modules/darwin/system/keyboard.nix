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
  # The ikki-68 external board also wants Left Command <-> Left Option. That is
  # per-device, which userKeyMapping can't express — do it in
  # System Settings > Keyboard > Keyboard Shortcuts > Modifier Keys with that
  # keyboard selected, then optionally capture
  # com.apple.keyboard.modifiermapping.28779-17-0 into CustomUserPreferences.

  # --- Caps Lock -> Google Japanese IME かな <-> halfwidth alphanumeric ------
  #
  # Replaces the karabiner "Google Alphanumeric/Hiragana" complex_modifications.
  # macOS does this natively:
  #   System Settings > Keyboard > Input Sources > Edit... >
  #   "Use the Caps Lock key to switch to and from <Japanese - Google>"
  # (requires "Japanese - Google" to be an enabled input source first).
  #
  # It writes com.apple.HIToolbox; the exact key is version/machine specific.
  # Capture it once, then paste the delta below:
  #
  #   defaults read com.apple.HIToolbox > /tmp/hit.before
  #   # ...toggle the setting ON in System Settings...
  #   defaults read com.apple.HIToolbox > /tmp/hit.after
  #   diff /tmp/hit.before /tmp/hit.after
  #
  # system.defaults.CustomUserPreferences."com.apple.HIToolbox" = {
  #   # <captured keys>
  # };
  #
  # Google IME's own keymap (Caps Lock -> "set to alphanumeric", かな ->
  # "set to Hiragana") is a binary protobuf and stays a one-time manual step.
}
