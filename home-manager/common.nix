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
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initContent = builtins.readFile ./../configs/zsh/.zshrc;
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

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

  programs.firefox.enable = true;

  home.file = {
    ".zshrc".source = ./../configs/zsh/.zshrc;
    ".config/zsh".source = ./../configs/zsh;
    ".config/nvim/init.lua".source = ./../configs/nvim/init.lua;
    ".config/nvim/lua".source = ./../configs/nvim/lua;
  };
}
