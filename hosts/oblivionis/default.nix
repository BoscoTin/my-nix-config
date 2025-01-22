{
  pkgs,
  inputs,
  vars,
  ...
}:

{
  imports = [
    ../base/module_config.nix
    ./darwin_config.nix
  ];

  users.users.${vars.username}.shell = pkgs.zsh;

  # use hm user
  home-manager.users.${vars.username} = {
    imports = [ ./hm_config.nix ] ++ inputs.self.hmModules;
    _module.args = {
      inherit inputs vars;
    };
  };

  # nix settings
  system.stateVersion = 4;
}