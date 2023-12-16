{ pkgs, lib, ... }:
{
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Enable experimental nix command and flakes
  # nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  # https://github.com/zmre/nix-config/blob/main/modules/darwin/core.nix
  # https://gist.github.com/Moscarda/1abb40b39c6636d4f022cbfbd90cf890
  environment.extraInit = ''
    # Close any open System Preferences panes, to prevent them from overriding
    # settings we’re about to change
    osascript -e 'tell application "System Preferences" to quit'
  '';

  system.defaults.CustomSystemPreferences = {
    "com.apple.Safari" = {
      ShowFullURLInSmartSearchField = true;
      ShowOverlayStatusBar = true;
      AutoOpenSafeDownloads = false;
      IncludeDevelopMenu = true;
      AutoFillFromAddressBook = false;
      AutoFillPasswords = false;
      AutoFillCreditCardData = false;
      AutoFillMiscellaneousForms = false;
    };
  };

  system.defaults.CustomUserPreferences = {
    "com.apple.finder" = {
      _FXSortFoldersFirst = true; # Keep folders on top when sorting by name
    };
  };

  # allow touchid to auth sudo -- this comes from pam.nix, which needs to be loaded before this
  # it's now standard to nix-darwin, but without the special such needed for tmux, so we
  # will continue using our custom script
  security.pam.enableCustomSudoTouchIdAuth = true;
  # security.pam.enableSudoTouchIdAuth = true;

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
  system.defaults.dock.mru-spaces = false;
  system.defaults.dock.orientation = "left";
  system.defaults.dock.show-recents = false;
  system.defaults.dock.tilesize = 50;

  # Screencapture
  system.defaults.screencapture.disable-shadow = true;

  # Screensaver -- doesn't work
  # system.defaults.screensaver.askForPassword = true;
  # system.defaults.screensaver.askForPasswordDelay = 0;

  # Keyboard
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  # Trackpad
  system.defaults.trackpad.TrackpadThreeFingerDrag = true;
  system.defaults.trackpad.TrackpadRightClick = true;
  system.defaults.trackpad.Clicking = true;
  system.defaults.magicmouse.MouseButtonMode = "TwoButton";

  # system.defaults.universalaccess.closeViewScrollWheelToggle = true;

  system.defaults.loginwindow.GuestEnabled = false;

  # Finder
  system.defaults.finder.FXDefaultSearchScope = "SCcf";
}
