#!/usr/bin/env bash

echo "=== Let's go! ==="

echo "=== System Preferences ==="
echo "Closing System Preferences window"
osascript -e 'tell application "System Preferences" to quit' || true

echo "=== Computer Name Setup ==="
scutil --get ComputerName > /tmp/cn
read -r current_name < /tmp/cn
echo -n "Set computer name [$current_name]: "
read -r computer_name

if [[ -n "$computer_name" && "$computer_name" != "$current_name" ]]; then
  echo "> Setting ComputerName to: $computer_name"
  sudo scutil --set ComputerName "$computer_name" || { echo "Failed to set ComputerName"; exit 1; }
  sudo scutil --set HostName "$computer_name" || { echo "Failed to set HostName"; exit 1; }
  sudo scutil --set LocalHostName "$computer_name" || { echo "Failed to set LocalHostName"; exit 1; }
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$computer_name" || { echo "Failed to set NetBIOSName"; exit 1; }
  echo "Computer name set (System Preferences → Sharing)"
else
  echo "Computer name unchanged"
fi

echo "=== Appearance & UI ==="
echo "> Tools and Look"
defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600" || { echo "Failed to set highlight color"; exit 1; }
echo "Set highlight color to green"

launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2>/dev/null || true
echo "Disable Notification Center and remove menu bar icon"

defaults write com.apple.menuextra.battery ShowPercent -string 'YES' || { echo "Failed to show battery"; exit 1; }
echo "Show battery percentage"

defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0 || { echo "Failed to adjust toolbar delay"; exit 1; }
echo "Adjust toolbar title rollover delay"

echo "=== Finder Preferences ==="
defaults write com.apple.finder WarnOnEmptyTrash -bool false || exit 1
defaults write com.apple.finder _FXSortFoldersFirst -bool true || exit 1
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf" || exit 1
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false || exit 1
defaults write com.apple.finder NewWindowTarget -string PfHm || exit 1
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}" || exit 1
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false || exit 1
defaults write com.apple.finder QuitMenuItem -bool true || exit 1
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false || exit 1
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true || exit 1
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true || exit 1
defaults write com.apple.finder DisableAllAnimations -bool true || exit 1

echo "Finder fine tuning completed"

echo "=== Audio Settings ==="
sudo nvram SystemAudioVolume=" " || exit 1
sudo nvram StartupMute=%01 || exit 1
defaults write com.apple.sound.beep.feedback -bool false || exit 1
defaults write "Apple Global Domain" "com.apple.sound.beep.volume" -float 0 || exit 1
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40 || exit 1

echo "Audio settings applied"

echo "=== Keyboard Settings ==="
defaults write -g KeyRepeat -int 1 || exit 1
defaults write -g InitialKeyRepeat -int 15 || exit 1
defaults write -g ApplePressAndHoldEnabled -bool false || exit 1
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false || exit 1

defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false || exit 1
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false || exit 1
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false || exit 1
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false || exit 1
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3 || exit 1

launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2>/dev/null || true

echo "Keyboard configured"

echo "=== Trackpad Settings ==="
defaults write com.apple.AppleMultitouchTrackpad ForceSuppressed -bool true || exit 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad DragLock -bool false || exit 1
defaults write com.apple.AppleMultitouchTrackpad DragLock -bool false || exit 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool false || exit 1
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool false || exit 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool false || exit 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool false || exit 1

defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true || exit 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true || exit 1
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 || exit 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 || exit 1

defaults write .GlobalPreferences com.apple.trackpad.scaling -int 2 || exit 1

defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true || exit 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -int 1 || exit 1
defaults -currentHost write -g com.apple.trackpad.enableSecondaryClick -bool true || exit 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 0 || exit 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 0 || exit 1
defaults -currentHost write -g com.apple.trackpad.trackpadCornerClickBehavior -int 0 || exit 1

echo "Trackpad configured"

echo "=== Security & Privacy ==="
sudo fdesetup enable || true
echo "FileVault enabled (or already active)"

sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false || exit 1
echo "Disabled captive network control"

sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on || exit 1
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on || exit 1
echo "Firewall enabled"

sudo tmutil disable || true
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true || exit 1
echo "Time Machine disabled"

defaults write com.apple.screensaver askForPassword -int 1 || exit 1
defaults write com.apple.screensaver askForPasswordDelay -int 0 || exit 1
echo "Require password immediately after sleep/screensaver"

sudo defaults write com.apple.LaunchServices LSQuarantine -bool NO || exit 1
echo "Disable quarantining of Downloads and all other files"

echo "=== Photos Preferences ==="
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true || exit 1
echo "Prevent Photos from opening on device plug-in"

echo "=== Display & Screen ==="
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true || exit 1
sudo defaults write com.apple.universalaccess reduceMotion -bool true || exit 1
sudo defaults write com.apple.universalaccess reduceTransparency -bool true || exit 1
echo "Display settings applied"

echo "=== Dock & Mission Control ==="
defaults write com.Apple.Dock showLaunchpadGestureEnabled -bool false || exit 1
defaults write com.Apple.Dock showAppExposeGestureEnabled -bool false || exit 1
defaults write com.Apple.Dock show-recents -bool false || exit 1

defaults write com.apple.dock magnification -int 1 || exit 1
defaults write com.apple.dock largesize -int 50 || exit 1
defaults write com.apple.dock persistent-apps -array || exit 1
defaults write com.apple.dock persistent-others -array || exit 1
defaults write com.apple.dock showhidden -bool true || exit 1
defaults write com.apple.dock tilesize -int 22 || exit 1
defaults write com.apple.dock orientation -string 'right' || exit 1
defaults write com.apple.dock show-process-indicators -bool false || exit 1

defaults write com.apple.dock mru-spaces -bool false || exit 1
defaults write com.apple.dock wvous-tl-corner -int 0 || exit 1
defaults write com.apple.dock wvous-tr-corner -int 0 || exit 1
defaults write com.apple.dock wvous-bl-corner -int 0 || exit 1
defaults write com.apple.dock wvous-br-corner -int 0 || exit 1
defaults write com.apple.dock expose-animation-duration -float 0.1 || exit 1

echo "Dock and Mission Control configured"

echo "=== Miscellaneous Settings ==="
defaults write org.hammerspoon.Hammerspoon MJConfigFile -string "~/.config/.hammerspoon/init.lua" || exit 1

defaults write -g NSAutomaticCapitalizationEnabled -bool false || exit 1
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false || exit 1
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false || exit 1
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false || exit 1
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false || exit 1
defaults write -g NSAutomaticTextCompletionEnabled -bool false || exit 1

defaults write com.apple.ActivityMonitor ShowCategory -int 0 || exit 1
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "I AM SERIOUS" || exit 1
sudo defaults write /Library/Preferences/com.apple.alf allowdownloadsignedenabled -bool false || true
sudo defaults write /Library/Preferences/com.apple.alf allowsignedenabled -bool false || true
sudo defaults write /Library/Preferences/com.apple.loginwindow DisableConsoleAccess -bool true || exit 1

sudo /usr/libexec/PlistBuddy -c "Set 'AC Power':'Display Sleep Timer' 5" /Library/Preferences/com.apple.PowerManagement.plist || exit 1

defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false || exit 1
defaults write com.apple.CrashReporter DialogType -string "none" || exit 1
defaults write NSGlobalDomain AppleFontSmoothing -int 2 || exit 1
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true || exit 1
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true || exit 1

sudo pmset -a sms 0 || exit 1

defaults write com.apple.AdLib allowApplePersonalizedAdvertising -int 0 || exit 1

echo "Miscellaneous tweaks applied"

echo "=== Spotlight Preferences ==="
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
  '{"enabled" = 0;"name" = "MENU_OTHER";}' || exit 1
echo "Spotlight preferences set"

echo "=== Finishup and Cleanup ==="
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

echo "> You probably want to restart your machine now...."
echo "All done!"
