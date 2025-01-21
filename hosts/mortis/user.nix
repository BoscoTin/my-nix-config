{
  pkgs,
  inputs,
  ...
}:

{
  users.users.${vars.hmUsername}.home = "/Users/${vars.username}";
    
  networking = {
    hostName = "00-${vars.hmUsername}";
    localHostName = "00-${vars.hmUsername}";
  };
}