{ ... }:

{
  # --- Caps Lock -> Google Japanese IME かな <-> halfwidth alphanumeric --------
  #
  # Replaces the old karabiner workaround. macOS does this natively:
  #   System Settings > Keyboard > Input Sources > Edit... >
  #   "Use the Caps Lock key to switch to and from <Japanese - Google>"
  #
  # It writes com.apple.HIToolbox, but the exact key is version/machine
  # specific. Capture it once, then paste the delta into the block below:
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
  #
  # Fully-declarative fallback (NOT a toggle — Caps always emits 英数/Lang2;
  # bind the reverse inside Google IME):
  #
  # system.keyboard.enableKeyMapping = true;
  # system.keyboard.userKeyMapping = [
  #   {
  #     HIDKeyboardModifierMappingSrc = 30064771129; # 0x700000039 caps lock
  #     HIDKeyboardModifierMappingDst = 30064771217; # 0x700000091 Lang2 (英数)
  #   }
  # ];

  # --- ctrl <-> cmd and other modifier swaps ---------------------------------
  # System Settings > Keyboard > Keyboard Shortcuts > Modifier Keys (per
  # keyboard). Not nix-managed — it is keyed by USB vendor/product id.
}
