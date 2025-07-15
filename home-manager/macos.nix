{ config, lib, pkgs, ... }:

{
  imports = [
    ./common.nix
    ./brew.nix
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

  targets.darwin = {
    currentHostDefaults = {
      # Dock settings
      "com.apple.dock" = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.0;
        show-recents = false;
        tilesize = 48;
        largesize = 64;
        magnification = true;
        minimize-to-application = true;
        mru-spaces = false;
        persistent-apps = [ ];
        persistent-others = [ ];
        show-process-indicators = true;
        static-only = false;
        wvous-bl-corner = 1;
        wvous-bl-modifier = 0;
        wvous-br-corner = 1;
        wvous-br-modifier = 0;
        wvous-tl-corner = 1;
        wvous-tl-modifier = 0;
        wvous-tr-corner = 1;
        wvous-tr-modifier = 0;
      };

      # Finder settings
      "com.apple.finder" = {
        ShowPathbar = true;
        ShowStatusBar = true;
        FXPreferredViewStyle = "Nlsv";
        FXEnableExtensionChangeWarning = false;
        FXRemoveOldTrashItems = true;
        CreateDesktop = false;
        ShowHardDrivesOnDesktop = false;
        ShowRemovableMediaOnDesktop = false;
        ShowMountedServersOnDesktop = false;
        ShowExternalHardDrivesOnDesktop = false;
      };

      # Global settings
      "NSGlobalDomain" = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        PMPrintingExpandedStateForPrint = true;
        PMPrintingExpandedStateForPrint2 = true;
        WebKitDeveloperExtras = true;
      };

      # Screenshot settings
      "com.apple.screencapture" = {
        location = "~/Desktop";
        type = "png";
      };

      # Security settings
      "com.apple.screensaver" = {
        askForPassword = 1;
        askForPasswordDelay = 0;
      };

      # Trackpad settings
      "com.apple.driver.AppleBluetoothMultitouch.trackpad" = {
        Clicking = true;
        TrackpadRightClick = true;
        TrackpadThreeFingerDrag = true;
      };

      # Mission Control settings
      "com.apple.dock" = {
        mru-spaces = false;
      };
    };
  };
}
