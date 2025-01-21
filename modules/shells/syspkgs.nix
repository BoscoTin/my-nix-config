{
  config,
  pkgs,
  ...
}:

{
  environment.systemPackages = (
    with pkgs; [
      fastfetch

      zip
      ripgrep
      eza
      jq
      fd

      ctop

      kubectl
      kubectx
      teleport_15
      k9s
      stern

      awscli2
      terraform
    ]
  ) ++ lib.optionals (pkgs.system != "x86_64-darwin") (
    with pkgs; [
      git-trim
    ]
  );
}