# generate ssh key

```
ssh-keygen -t ed25519 -C "" -f ~/.ssh/
```

```
cat ~/.ssh/.pub | pbcopy
```

# Template

Add file to git-users/
```
{ ... }:

{
  contents = {
    user = {
      name = "";
      email = "";
    };

    core = {
      sshCommand = "ssh -i ~/.ssh/<ur private key file>";
    };
  };

  condition = "hasconfig:remote.*.url:<remote-host>/<organization>/*";
}
```

# Steps

1. import in git.nix -> includes

2. git add *

3. nix rebuild

4. if not work, add ssh key to agent `ssh-add --apple-use-keychain ~/.ssh/<ur private key file>`