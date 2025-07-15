{ config, lib, pkgs, ... }:

{
  home.sessionVariables = {
    PAGER = "less";
    LESS = "-R";
    MANPAGER = "less -R";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    NIX_DOTS_CONFIG = "$HOME/.config/nix";
  };

  home.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;

  # Shared packages for both Arch and macOS
  home.packages = with pkgs; [
    # Core utilities
    zsh
    ffmpeg
    git
    ripgrep
    fd
    fzf
    tree
    htop
    tmux
    wget
    curl
    unzip
    zip
    rsync
    ncdu
    sd

    lazygit
  ];

  home.file = {
    ".zshrc".source = ./../configs/zsh/.zshrc;
    ".config/zsh".source = ./../configs/zsh;
    ".config/nvim/init.lua".source = ./../configs/nvim/init.lua;
    ".config/nvim/lua".source = ./../configs/nvim/lua;
  };

  home.activation = {
    createZshCache = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD mkdir -p $VERBOSE_ARG $HOME/.cache/zsh
    '';
  };
}
