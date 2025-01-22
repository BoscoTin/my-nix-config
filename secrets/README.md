# git extra users template 

```
{ ... }:

{
  contents = {
    user = {
      name = "";
      email = "";
    };
  };

  # refer https://git-scm.com/docs/git-config#_conditional_includes
  condition = "hasconfig:remote.*.url:https://example.com/**";
}
```