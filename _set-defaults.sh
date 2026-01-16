#!/usr/bin/env bash

set -euo pipefail

section() {
    echo "=== $1 ==="
}

say(){
    echo "> $1"
}

function close_system_preferences() {
  section "System Preferences"
  echo "Closing System Preferences window"
  osascript -e 'tell application "System Preferences" to quit'
}

function set_computer_name() {
  section "Computer Name Setup"
  local current_name
  current_name=$(scutil --get ComputerName)
  echo -n "Set computer name [$current_name]: "
  read -r computer_name

  if [[ -n "$computer_name" && "$computer_name" != "$current_name" ]]; then
    say "Setting ComputerName to: $computer_name"
    sudo scutil --set ComputerName "$computer_name"
    sudo scutil --set HostName "$computer_name"
    sudo scutil --set LocalHostName "$computer_name"
    sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$computer_name"
    echo "Computer name set (System Preferences → Sharing)"
  else
    echo "Computer name unchanged"
  fi
}

function appearance_ui() {
  section "Appearance & UI"
  say "Tools and Look"
  defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"
  echo "Set highlight color to green"

  launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2>/dev/null || true
  echo "Disable Notification Center and remove menu bar icon"

  defaults write com.apple.menuextra.battery ShowPercent -string 'YES'
  echo "Show battery percentage"

  defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0
  echo "Adjust toolbar title rollover delay"
}

function finder_preferences() {
  section "Finder Preferences"
  defaults write com.apple.finder WarnOnEmptyTrash -bool false
  defaults write com.apple.finder _FXSortFoldersFirst -bool true
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
  defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
  defaults write com.apple.finder NewWindowTarget -string PfHm
  defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
  defaults write com.apple.finder QuitMenuItem -bool true
  defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
  defaults write com.apple.finder DisableAllAnimations -bool true

  echo "Finder fine tuning completed"
}

function audio_settings() {
  section "Audio Settings"
  sudo nvram SystemAudioVolume=" "
  sudo nvram StartupMute=%01
  defaults write com.apple.sound.beep.feedback -bool false
  defaults write "Apple Global Domain" "com.apple.sound.beep.volume" -float 0
  defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

  echo "Audio settings applied"
}

function keyboard_settings() {
  section "Keyboard Settings"
  defaults write -g KeyRepeat -int 1
  defaults write -g InitialKeyRepeat -int 15
  defaults write -g ApplePressAndHoldEnabled -bool false
  defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

  defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
  defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
  defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false
  defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

  launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2>/dev/null || true

  echo "Keyboard configured"
}

function trackpad_settings() {
  section "Trackpad Settings"
  defaults write com.apple.AppleMultitouchTrackpad ForceSuppressed -bool true
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad DragLock -bool false
  defaults write com.apple.AppleMultitouchTrackpad DragLock -bool false
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool false
  defaults write com.apple.AppleMultitouchTrackpad Dragging -bool false
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool false
  defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool false

  defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

  defaults write .GlobalPreferences com.apple.trackpad.scaling -int 2

  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
  defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -int 1
  defaults -currentHost write -g com.apple.trackpad.enableSecondaryClick -bool true
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 0
  defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 0
  defaults -currentHost write -g com.apple.trackpad.trackpadCornerClickBehavior -int 0

  echo "Trackpad configured"
}

function security_privacy() {
  section "Security & Privacy"
  sudo fdesetup enable || true
  echo "FileVault enabled (or already active)"

  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false
  echo "Disabled captive network control"

  sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
  sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on
  echo "Firewall enabled"

  sudo tmutil disable || true
  defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
  echo "Time Machine disabled"

  defaults write com.apple.screensaver askForPassword -int 1
  defaults write com.apple.screensaver askForPasswordDelay -int 0
  echo "Require password immediately after sleep/screensaver"
}

function photos_preferences() {
  section "Photos Preferences"
  defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
  echo "Prevent Photos from opening on device plug-in"
}

function display_settings() {
  section "Display & Screen"
  sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true
  sudo defaults write com.apple.universalaccess reduceMotion -bool true
  sudo defaults write com.apple.universalaccess reduceTransparency -bool true
  echo "Display settings applied"
}

function dock_mission_control() {
  section "Dock & Mission Control"
  defaults write com.Apple.Dock showLaunchpadGestureEnabled -bool false
  defaults write com.Apple.Dock showAppExposeGestureEnabled -bool false
  defaults write com.Apple.Dock show-recents -bool false

  defaults write com.apple.dock magnification -int 1
  defaults write com.apple.dock largesize -int 50
  defaults write com.apple.dock persistent-apps -array
  defaults write com.apple.dock persistent-others -array
  defaults write com.apple.dock showhidden -bool true
  defaults write com.apple.dock tilesize -int 22
  defaults write com.apple.dock orientation -string 'right'
  defaults write com.apple.dock show-process-indicators -bool false

  defaults write com.apple.dock mru-spaces -bool false
  defaults write com.apple.dock wvous-tl-corner -int 0
  defaults write com.apple.dock wvous-tr-corner -int 0
  defaults write com.apple.dock wvous-bl-corner -int 0
  defaults write com.apple.dock wvous-br-corner -int 0
  defaults write com.apple.dock expose-animation-duration -float 0.1

  echo "Dock and Mission Control configured"
}

function miscellaneous_settings() {
  section "Miscellaneous Settings"
  defaults write org.hammerspoon.Hammerspoon MJConfigFile -string "~/.config/.hammerspoon/init.lua"

  defaults write -g NSAutomaticCapitalizationEnabled -bool false
  defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
  defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
  defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
  defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
  defaults write -g NSAutomaticTextCompletionEnabled -bool false

  defaults write com.apple.ActivityMonitor ShowCategory -int 0
  sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "I AM SERIOUS"
  sudo defaults write /Library/Preferences/com.apple.alf allowdownloadsignedenabled -bool false || true
  sudo defaults write /Library/Preferences/com.apple.alf allowsignedenabled -bool false || true
  sudo defaults write /Library/Preferences/com.apple.loginwindow DisableConsoleAccess -bool true

  sudo /usr/libexec/PlistBuddy -c "Set 'AC Power':'Display Sleep Timer' 5" /Library/Preferences/com.apple.PowerManagement.plist

  defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
  defaults write com.apple.CrashReporter DialogType -string "none"
  defaults write NSGlobalDomain AppleFontSmoothing -int 2
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

  sudo pmset -a sms 0

  defaults write com.apple.AdLib allowApplePersonalizedAdvertising -int 0

  echo "Miscellaneous tweaks applied"
}

function spotlight_preferences() {
  section "Spotlight Preferences"
  defaults write com.apple.spotlight orderedItems -array \
    '{"enabled" = 1;"name" = "APPLICATIONS";}' \
    '{"enabled" = 1;"name" = "MENU_EXPRESSION";}' \
    '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}' \
    '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
    '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
    '{"enabled" = 0;"name" = "SYSTEM_PREFS";}' \
    '{"enabled" = 0;"name" = "DOCUMENTS";}' \
    '{"enabled" = 0;"name" = "DIRECTORIES";}' \
    '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
    '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
    '{"enabled" = 0;"name" = "PDF";}' \
    '{"enabled" = 0;"name" = "MESSAGES";}' \
    '{"enabled" = 0;"name" = "CONTACT";}' \
    '{"enabled" = 0;"name" = "EVENT_TODO";}' \
    '{"enabled" = 0;"name" = "IMAGES";}' \
    '{"enabled" = 0;"name" = "BOOKMARKS";}' \
    '{"enabled" = 0;"name" = "MUSIC";}' \
    '{"enabled" = 0;"name" = "MOVIES";}' \
    '{"enabled" = 0;"name" = "FONTS";}' \
    '{"enabled" = 0;"name" = "MENU_OTHER";}'
  echo "Spotlight preferences set"
}

function finish_cleanup() {
  section "Finishup and Cleanup"
  killall "SystemUIServer" > /dev/null 2>&1 || true
  echo "Restarted SystemUIServer"

  killall "Finder" > /dev/null 2>&1 || true
  echo "Restarted Finder"

  killall "Dock" > /dev/null 2>&1 || true
  echo "Restarted Dock"

  killall mds > /dev/null 2>&1 || true
  echo "Restarted Spotlight daemon"

  sudo mdutil -i on / > /dev/null 2>&1 || true
  echo "Enabled Spotlight indexing on main volume"

  sudo mdutil -E / > /dev/null 2>&1 || true
  echo "Rebuilt Spotlight index"

  killall "cfprefsd" > /dev/null 2>&1 || true
  echo "Killed cached preferences daemon"

  say "You probably want to restart your machine now...."
  echo "All done!"
}



section "Let's go!"
close_system_preferences
set_computer_name
appearance_ui
finder_preferences
audio_settings
keyboard_settings
trackpad_settings
security_privacy
photos_preferences
display_settings
dock_mission_control
miscellaneous_settings
spotlight_preferences
finish_cleanup
