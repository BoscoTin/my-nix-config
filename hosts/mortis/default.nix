{
  pkgs,
  vars,
  ...
}:

{
  imports = [
    ./user.nix
    ./darwin.nix
  ];

  # shell
  users.users.${vars.hmUsername}.shell = pkgs.zsh;

  programs = {
    zsh.enable = true;
    direnv.enable = true;
  };

  # nix settings
  system.stateVersion = 4;
}