{ ... }:

{
  contents = {
    core = {
      sshCommand = "ssh -i ~/.ssh/ps_gitlab";
    };
  };

  condition = "hasconfig:remote.*.url:git@gitlab.com:*";
}