# https://github.com/zmre/nix-config/blob/main/modules/darwin/core.nix
# https://gist.github.com/Moscarda/1abb40b39c6636d4f022cbfbd90cf890
{
  system.defaults = {
    NSGlobalDomain = {
      ApplePressAndHoldEnabled = false;
      InitialKeyRepeat = 15;
      KeyRepeat = 1;
      # Dark mode
      AppleInterfaceStyle = "Dark";
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };

    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.2;
      expose-animation-duration = 0.2;
      minimize-to-application = true;
      mru-spaces = false;
      orientation = "left";
      show-recents = false;
      tilesize = 48;
    };

    screencapture = {
      disable-shadow = true;
      location = "~/Desktop";
      type = "png";
    };

    # doesn't work
    screensaver = {
      askForPassword = true;
      askForPasswordDelay = 0;
    };

    trackpad = {
      TrackpadThreeFingerDrag = true;
      TrackpadRightClick = true;
      Clicking = true;
    };

    magicmouse = {
      MouseButtonMode = "TwoButton";
    };

    # universalaccess = {
    #   closeViewScrollWheelToggle = true;
    # };

    loginwindow = {
      GuestEnabled = false;
    };

    finder = {
      # When performing a search, search the current folder by default
      FXDefaultSearchScope = "SCcf";
    };

    CustomSystemPreferences = {};
    CustomUserPreferences = {
      "com.apple.finder" = {
        _FXSortFoldersFirst = true; # Keep folders on top when sorting by name
        ShowExternalHardDrivesOnDesktop = true;
        ShowHardDrivesOnDesktop = true;
        ShowMountedServersOnDesktop = true;
        ShowRemovableMediaOnDesktop = true;
      };
      "com.apple.desktopservices" = {
        # Avoid creating .DS_Store files on network or USB volumes
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.Safari" = {
        ShowFullURLInSmartSearchField = true;
        ShowOverlayStatusBar = true;
        # Prevent Safari from opening ‘safe’ files automatically after downloading
        AutoOpenSafeDownloads = false;
        IncludeInternalDebugMenu = true;
        IncludeDevelopMenu = true;
        WebKitDeveloperExtrasEnabledPreferenceKey = true;
        WebContinuousSpellCheckingEnabled = true;
        WebAutomaticSpellingCorrectionEnabled = false;
        AutoFillFromAddressBook = false;
        AutoFillPasswords = false;
        AutoFillCreditCardData = false;
        AutoFillMiscellaneousForms = false;
        WarnAboutFraudulentWebsites = true;
      };
      "com.apple.SoftwareUpdate" = {
        AutomaticCheckEnabled = true;
        # Check for software updates daily, not just once per week
        ScheduleFrequency = 1;
        # Download newly available updates in background
        AutomaticDownload = 1;
        # Install System data files & security updates
        CriticalUpdateInstall = 1;
      };
    };
  };
}
