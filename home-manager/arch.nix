{ config, lib, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initContent = builtins.readFile ./../configs/zsh/.zshrc;
  };

  programs.firefox = {
    enable = true;
  };

  # Neovim configuration
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  # Git configuration
  programs.git = {
    enable = true;
    userName = "karasikq";
    userEmail = "romastepanuik@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
