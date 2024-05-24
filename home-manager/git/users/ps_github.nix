{ username, useremail, ... }:

{
  contents = {
    user = {
      name = username;
      email = useremail;
    };

    core = {
      sshCommand = "ssh -i ~/.ssh/ps_github";
    };
  };

  condition = "hasconfig:remote.*.url:git@github.com:BoscoTin/*";
}