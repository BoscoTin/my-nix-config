{
  vars,
  ...
}:

{
  imports = [
    ../base/hm_config.nix
  ];

  # here the enable configs are under home-manager, should refer to hm-module.nix for toggle
  xdg.enable = true;
  programs = {
    git.enable = true;
    zsh.enable = true;
    direnv.enable = true;
    vscode.enable = true;
    go.enable = true;
    ghostty.enable = true;
  };
}
