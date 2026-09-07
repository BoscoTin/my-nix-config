{
  pkgs,
  ...
}:

{
  # extensions.autoCheckUpdates lives in config/vscode/settings.json now
  programs.vscode.profiles.default.extensions =
    (with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
    ])
    ++ (with pkgs.vscode-marketplace; [
      hashicorp.terraform
      eamodio.gitlens
      jnoortheen.nix-ide
      golang.go
      zxh404.vscode-proto3
      esbenp.prettier-vscode
    ]);
    # ++ lib.optionals (vars.isCasualProfile == true) (
    #   with pkgs.vscode-marketplace; [
    #     sourcegraph.cody-ai
    #   ]
    # );
}