# Shared system config for every host. Imported by profiles/{casual,work}.nix.
{
  pkgs,
  vars,
  ...
}:

{
  users.users.${vars.username} = {
    home = "/Users/${vars.username}";
    shell = pkgs.zsh;
  };

  networking = {
    hostName = "00-${vars.username}-${vars.device}";
    localHostName = "00-${vars.username}-${vars.device}";
  };

  # nix-darwin multi-user migration: activation runs as root, and the
  # primary-user-scoped options (homebrew, NSGlobalDomain defaults, ...)
  # apply to this user. Required or activation aborts with an assertion.
  system.primaryUser = vars.username;

  # register zsh in /etc/shells so it is a valid login shell without manual chsh
  environment.shells = [ pkgs.zsh ];

  fonts.packages = with pkgs; [
    meslo-lgs-nf
    source-code-pro
    nerd-fonts.fira-code
    nerd-fonts.symbols-only
  ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = 4;
}
