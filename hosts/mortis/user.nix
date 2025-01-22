{
  pkgs,
  vars,
  ...
}:

{
  users.users.${vars.hmUsername}.home = "/Users/${vars.hmUsername}";
    
  networking = {
    hostName = "00-${vars.hmUsername}";
    localHostName = "00-${vars.hmUsername}";
  };
}