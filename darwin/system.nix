{ pkgs, ... }:
{
  users.users.bosco = {
    home = "/Users/bosco";
    shell = "${pkgs.zsh}/bin/zsh";
  };
}