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

  # fix on 25.11 error: Build user group has mismatching GID, aborting activation
  ids.gids.nixbld = 350;
}