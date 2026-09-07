{
  config,
  osConfig,
  ...
}:

{
  imports = [
    ./extensions.nix
  ];

  # declared extensions are ensured, but the dir stays writable so the GUI /
  # `code --install-extension` can add more
  programs.vscode.mutableExtensionsDir = true;

  # settings.json is a live symlink into the repo working tree: GUI edits
  # persist, show up in `git diff`, and need no rebuild
  home.file."Library/Application Support/Code/User/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${osConfig.my.repoPath}/config/vscode/settings.json";
}
