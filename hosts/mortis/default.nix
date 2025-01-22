{
  pkgs,
  inputs,
  vars,
  ...
}:

{
  imports = [
    ./user.nix
    ./darwin.nix
  ];

  users.users.${vars.hmUsername}.shell = pkgs.zsh;

  # use hm user
  home-manager.users.${vars.hmUsername} = {
    imports = [ ./hm_config.nix ] ++ inputs.self.hmModules;
    _module.args = {
      inherit inputs vars;
    };
  };

  # nix settings
  system.stateVersion = 4;
  nixpkgs.config.allowUnfree = true;
}