{
  pkgs,
  vars,
  ...
}:

{
  imports = [
    ./user.nix
  ];

  # shell
  users.users.${vars.hmUsername}.shell = pkgs.zsh;
  programs.zsh.enable = true;

  # nix settings
  system.stateVersion = 4;
}