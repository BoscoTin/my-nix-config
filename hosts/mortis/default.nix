{
  pkgs,
  inputs,
  modules,
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

  # use hm user
  home-manager.users.${vars.hmUsername} = {
    imports = [ ./hm_user.nix ] ++ modules.home;
    _module.args = {
      inherit inputs vars;
    };
  };

  # nix settings
  system.stateVersion = 4;
}