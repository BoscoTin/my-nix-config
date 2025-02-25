# git extra users template 

```
{ ... }:

{
  contents = {
    user = {
      name = "";
      email = "";
    };
    core = {
      sshCommand = "ssh -i ~/.ssh/id_example";
    };
  };

  # refer https://git-scm.com/docs/git-config#_conditional_includes
  condition = "hasconfig:remote.*.url:https://example.com/**";
}
```