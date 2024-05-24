{ ... }:

{
  contents = {
    core = {
      sshCommand = "ssh -i ~/.ssh/ps_github";
    };
  };

  condition = "hasconfig:remote.*.url:git@github.com:*";
}