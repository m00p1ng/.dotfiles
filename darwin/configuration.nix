{ pkgs, ... }:
{
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # https://github.com/zmre/nix-config/blob/main/modules/darwin/core.nix
  environment.extraInit = ''
    # Close any open System Preferences panes, to prevent them from overriding
    # settings we’re about to change
    osascript -e 'tell application "System Preferences" to quit'

    # Require password immediately after sleep or screen saver begins
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0

    # Keep folders on top when sorting by name
    defaults write com.apple.finder _FXSortFoldersFirst -bool true

    defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
    defaults write com.apple.Safari ShowOverlayStatusBar -bool true
    defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
    defaults write com.apple.Safari IncludeDevelopMenu -bool true
    defaults write com.apple.Safari AutoFillFromAddressBook -bool false
    defaults write com.apple.Safari AutoFillPasswords -bool false
    defaults write com.apple.Safari AutoFillCreditCardData -bool false
    defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false
  '';

  # TouchId
  security.pam.enableSudoTouchIdAuth = true;

  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;

  # Dock
  system.defaults.dock.autohide = true;
  system.defaults.dock.minimize-to-application = true;
  system.defaults.dock.orientation = "left";
  system.defaults.dock.show-recents = false;
  system.defaults.dock.tilesize = 50;

  # Screencapture
  system.defaults.screencapture.disable-shadow = true;

  # Keyboard
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  # Trackpad
  system.defaults.trackpad.TrackpadThreeFingerDrag = true;
  system.defaults.trackpad.TrackpadRightClick = true;
  system.defaults.trackpad.Clicking = true;

  system.defaults.universalaccess.closeViewScrollWheelToggle = true;

  system.defaults.loginwindow.GuestEnabled = false;

  # Finder
  system.defaults.finder.FXDefaultSearchScope = "SCcf";
}
