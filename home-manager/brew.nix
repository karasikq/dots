{ config, lib, pkgs, ... }:

{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    taps = [
      "homebrew/cask"
      "homebrew/cask-fonts"
      "homebrew/core"
    ];

    brews = [
      "imagemagick"
      "gpg"
      "pass"
    ];

    casks = [
      "iterm2"
      "firefox"
      "the-unarchiver"
      "font-jetbrains-mono"
    ];

    masApps = {
    };
  };
}
