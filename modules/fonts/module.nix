{
  pkgs,
  ...
}:

{
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      meslo-lgs-nf
      source-code-pro
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
  };
}