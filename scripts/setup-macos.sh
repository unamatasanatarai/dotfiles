#!/usr/bin/env bash

# IMPORTANT: DO NOT run this script with 'sudo'.
# The script will prompt for your password only when it needs it.
# Running the whole script as sudo will break Safari/User preferences.

if [[ $EUID -eq 0 ]]; then
	echo "Error: Please DO NOT run this script with sudo."
	echo "Run it as a normal user: ./_set-defaults.sh"
	exit 1
fi

echo "=== System Preferences ==="
# Quitting apps and killing cfprefsd before modifying their preferences is best practice
osascript -e 'tell application "System Preferences" to quit' || true
osascript -e 'tell application "System Settings" to quit' || true
osascript -e 'tell application "Safari" to quit' || true
killall "cfprefsd" &>/dev/null || true

# NOTE: For many of these 'defaults' commands to work (especially Safari),
# your Terminal must have "Full Disk Access" in System Settings > Privacy & Security.

# Trackpad: Silent Clicking
defaults write com.apple.AppleMultitouchTrackpad SilentClick -bool true || exit 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad SilentClick -bool true || exit 1
echo "Silent clicking enabled"

# Trackpad: 4-finger swipe between spaces/pages
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 0 || exit 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2 || exit 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 0 || exit 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerHorizSwipeGesture -int 2 || exit 1
echo "4-finger swipe between spaces/pages enabled"

# Keyboard: Do not adjust brightness in low light
sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Keyboard Brightness" -bool false || exit 1
echo "Automatic keyboard brightness disabled"

# Power: Display sleep (10 minutes)
sudo pmset -b displaysleep 10 || exit 1
sudo pmset -c displaysleep 10 || exit 1
echo "Display sleep set to 10 minutes"

echo "=== Computer Name Setup ==="
scutil --get ComputerName >/tmp/cn
read -r current_name </tmp/cn
echo "! Only alphanumeric characters and hyphens are allowed!"
echo -n "Set computer name [$current_name]: "
read -r computer_name

if [[ -n "$computer_name" && "$computer_name" != "$current_name" ]]; then
	echo "> Setting ComputerName to: $computer_name"
	sudo scutil --set ComputerName "$computer_name" || {
		echo "Failed to set ComputerName"
		exit 1
	}
	sudo scutil --set HostName "$computer_name" || {
		echo "Failed to set HostName"
		exit 1
	}
	sudo scutil --set LocalHostName "$computer_name" || {
		echo "Failed to set LocalHostName"
		exit 1
	}
	# Set the NetBIOS name (visible to Windows computers on the network)
	sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$computer_name" || {
		echo "Failed to set NetBIOSName"
		exit 1
	}
	echo "NetBIOS name set to $computer_name"
	echo "Computer name set (System Preferences → Sharing)"
else
	echo "Computer name unchanged"
fi

echo "=== Appearance & UI ==="
echo "> Tools and Look"

# Set the highlight color (the color of selected text)
defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600" || {
	echo "Failed to set highlight color"
	exit 1
}
echo "Highlight color set to green"

# Hide menu bar
defaults write NSGlobalDomain _HIHideMenuBar -bool true || exit 1
echo "Menu bar hidden"

# Disable Notification Center and remove its menu bar icon
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2>/dev/null || true
echo "Disable Notification Center and remove menu bar icon"

# Show battery percentage in the menu bar and control center
defaults write com.apple.menuextra.battery ShowPercent -string 'YES' || {
	echo "Failed to show battery"
	exit 1
}
echo "Battery percentage enabled in menu bar"
defaults write com.apple.controlcenter "NSStatusItem Visible Battery" -bool true || exit 1
echo "Battery visibility enabled in Control Center"
defaults write com.apple.controlcenter BatteryShowPercentage -bool true || exit 1
echo "Battery percentage enabled in Control Center"

# Remove the delay when hovering over a window title in the toolbar
defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0 || {
	echo "Failed to adjust toolbar delay"
	exit 1
}
echo "Removed toolbar title rollover delay"

echo "=== Finder Preferences ==="

# Disable the warning when emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false || exit 1
echo "Disabled empty Trash warning"

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true || exit 1
echo "Folders now sorted first"

# When performing a search, search the current folder by default (SCcf)
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf" || exit 1
echo "Search scope set to current folder"

# Hide hard drives on the desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false || exit 1
echo "Hard drives hidden on desktop"

# Set the default Finder location to the Home folder (PfHm)
defaults write com.apple.finder NewWindowTarget -string PfHm || exit 1
echo "New Finder windows now open to Home"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}" || exit 1
echo "New Finder window path set to $HOME"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false || exit 1
echo "Disabled file extension change warning"

# Allow quitting Finder via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true || exit 1
echo "Enabled Quit menu item in Finder"

# Disable window animations (opening/closing/resizing)
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false || exit 1
echo "Disabled window animations"

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true || exit 1
echo "Save panel expanded by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true || exit 1
echo "Save panel (2) expanded by default"

# Disable various Finder animations
defaults write com.apple.finder DisableAllAnimations -bool true || exit 1
echo "Disabled Finder animations"

# Show all filename extensions
defaults write com.apple.finder AppleShowAllExtensions -bool true || exit 1
echo "All filename extensions shown"

# Show the path bar at the bottom of Finder windows
defaults write com.apple.finder ShowPathbar -bool true || exit 1
echo "Finder path bar enabled"

# Show the status bar at the bottom of Finder windows (e.g., item count)
defaults write com.apple.finder ShowStatusBar -bool true || exit 1
echo "Finder status bar enabled"

# Show the full POSIX path in the Finder window title bar
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true || exit 1
echo "Full POSIX path shown in Finder title"

# Enable text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true || exit 1
echo "Quick Look text selection enabled"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true || exit 1
echo "Screenshot shadows disabled"

echo "Finder fine tuning completed"

echo "=== Audio Settings ==="

# Disable the sound effects on boot (Startup chime)
sudo nvram SystemAudioVolume=" " || exit 1
sudo nvram StartupMute=%01 || exit 1

# Disable the sound effect when changing volume
defaults write com.apple.sound.beep.feedback -bool false || exit 1
echo "Disabled volume change sound effect"

# Set the alert volume to 0
defaults write "Apple Global Domain" "com.apple.sound.beep.volume" -float 0 || exit 1
echo "Alert volume set to 0"

# Mute microphone
osascript -e "set volume input volume 0"
echo "Microphone muted"

# Disable UI sounds and volume change feedback
defaults write com.apple.systemsound "com.apple.sound.uiaudio.enabled" -int 0 || exit 1
defaults write .GlobalPreferences com.apple.sound.beep.feedback -int 0 || exit 1
echo "UI sounds and volume feedback disabled"

# Increase Bluetooth audio quality (bitpool min)
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40 || exit 1
echo "Bluetooth audio quality improved"

echo "Audio settings applied"

echo "=== Keyboard Settings ==="

# Set a very fast keyboard repeat rate
defaults write -g KeyRepeat -int 1 || exit 1
echo "Keyboard repeat rate set to maximum"
defaults write -g InitialKeyRepeat -int 15 || exit 1
echo "Keyboard initial repeat delay set"

# Disable "Press and Hold" for keys in favor of key repeat
defaults write -g ApplePressAndHoldEnabled -bool false || exit 1
echo "Disabled press-and-hold (Global)"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false || exit 1
echo "Disabled press-and-hold (NSGlobalDomain)"

# Disable various automatic text substitutions
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false || exit 1
echo "Disabled automatic quote substitution"
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false || exit 1
echo "Disabled automatic dash substitution"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false || exit 1
echo "Disabled automatic spelling correction"
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false || exit 1
echo "Disabled web automatic spelling correction"

# Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3 || exit 1
echo "Full keyboard access enabled"

# Remap Caps Lock to Control
# NOTE: This command is NOT persistent across reboots.
# For a persistent solution, use System Settings > Keyboard > Keyboard Shortcuts > Modifier Keys.
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x7000000E0}]}' || echo "Failed to remap Caps Lock via hidutil"
echo "Remapped Caps Lock to Control (Note: Not persistent across reboots)"

# Disable the "Media keys" (Play/Pause etc.) from launching iTunes/Music
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2>/dev/null || true

echo "Keyboard configured"

echo "=== Trackpad Settings ==="

# Disable Force Touch and haptic feedback
defaults write com.apple.AppleMultitouchTrackpad ForceSuppressed -bool true || exit 1
echo "Disabled trackpad Force Touch"

# Disable dragging with drag lock
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad DragLock -bool false || exit 1
echo "Disabled Bluetooth trackpad drag lock"
defaults write com.apple.AppleMultitouchTrackpad DragLock -bool false || exit 1
echo "Disabled trackpad drag lock"

# Disable standard dragging
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool false || exit 1
echo "Disabled Bluetooth trackpad standard dragging"
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool false || exit 1
echo "Disabled trackpad standard dragging"

# Enable three-finger drag
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true || exit 1
echo "Enabled Bluetooth trackpad three-finger drag"
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true || exit 1
echo "Enabled trackpad three-finger drag"
defaults write com.apple.Accessibility AppIconDragGesture -bool true || exit 1
echo "Enabled accessibility three-finger drag"
echo "Enabled three-finger drag"

# Enable tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true || exit 1
echo "Enabled trackpad tap-to-click"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true || exit 1
echo "Enabled Bluetooth trackpad tap-to-click"
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 || exit 1
echo "Enabled currentHost tap-to-click behavior"
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 || exit 1
echo "Enabled tap-to-click behavior"

# Set trackpad tracking speed
defaults write .GlobalPreferences com.apple.trackpad.scaling -int 2 || exit 1
echo "Trackpad tracking speed set"

# Enable right-click (secondary click) with two fingers
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true || exit 1
echo "Enabled Bluetooth trackpad right-click"
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -int 1 || exit 1
echo "Enabled trackpad right-click"
defaults -currentHost write -g com.apple.trackpad.enableSecondaryClick -bool true || exit 1
echo "Enabled currentHost secondary click"

# Disable corner secondary click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 0 || exit 1
echo "Disabled Bluetooth trackpad corner click"
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 0 || exit 1
echo "Disabled trackpad corner click"
defaults -currentHost write -g com.apple.trackpad.trackpadCornerClickBehavior -int 0 || exit 1
echo "Disabled currentHost trackpad corner click behavior"

echo "Trackpad configured"

echo "=== Security & Privacy ==="
# Enable FileVault (disk encryption)
sudo fdesetup enable || true
echo "FileVault enabled (or already active)"

# Disable captive network control (prevents opening a browser automatically for Wi-Fi logins)
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false || exit 1
echo "Disabled captive network control"

# Enable the firewall, set logging, and enable stealth mode
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on || exit 1
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on || exit 1
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on || exit 1
echo "Firewall enabled with logging and stealth mode"

# Disable Time Machine and prevent it from asking to use new disks for backup
sudo tmutil disable || true
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true || exit 1
echo "Disabled Time Machine (new disk offers)"

# Require a password immediately after sleep or screensaver begins
defaults write com.apple.screensaver askForPassword -int 1 || exit 1
echo "Password required for sleep/screensaver"
defaults write com.apple.screensaver askForPasswordDelay -int 0 || exit 1
echo "Password delay set to 0"

# Enable File Quarantine (LSQuarantine) for downloads (Security best practice)
sudo defaults write com.apple.LaunchServices LSQuarantine -bool YES || exit 1
echo "File Quarantine enabled"

echo "=== Photos Preferences ==="
# Prevent Photos from opening automatically when a device is plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true || exit 1
echo "Disabled Photos auto-open on plug-in"

echo "=== Display & Screen ==="
# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true || exit 1
echo "HiDPI display modes enabled"

# Reduce motion and transparency (accessibility)
sudo defaults write com.apple.universalaccess reduceMotion -bool true || exit 1
echo "Reduced motion enabled"
sudo defaults write com.apple.universalaccess reduceTransparency -bool true || exit 1
echo "Reduced transparency enabled"

echo "=== Dock & Mission Control ==="
# Disable various Dock gestures (Launchpad, App Expose)
defaults write com.Apple.Dock showLaunchpadGestureEnabled -bool false || exit 1
echo "Disabled Launchpad gesture"
defaults write com.Apple.Dock showAppExposeGestureEnabled -bool false || exit 1
echo "Disabled App Expose gesture"

# Don't show recent applications in the Dock
defaults write com.Apple.Dock show-recents -bool false || exit 1
echo "Disabled recent apps in Dock"

# Disable all hot corners
defaults write com.Apple.Dock wvous-tl-corner -int 0 || exit 1
defaults write com.Apple.Dock wvous-tr-corner -int 0 || exit 1
defaults write com.Apple.Dock wvous-bl-corner -int 0 || exit 1
defaults write com.Apple.Dock wvous-br-corner -int 0 || exit 1
echo "All Hot Corners disabled"

# Enable Dock magnification and set the sizes
defaults write com.apple.dock magnification -int 1 || exit 1
echo "Dock magnification enabled"
defaults write com.apple.dock largesize -int 50 || exit 1
echo "Dock magnification large size set"

# Clear all persistent apps and folders from the Dock
defaults write com.apple.dock persistent-apps -array || exit 1
echo "Cleared Dock persistent apps"
defaults write com.apple.dock persistent-others -array || exit 1
echo "Cleared Dock persistent others"

# Show hidden applications in the Dock (translucent icons)
defaults write com.apple.dock showhidden -bool true || exit 1
echo "Show hidden apps in Dock enabled"

# Widgets: Turn off iPhone widgets
defaults write com.apple.widgets useiPhoneWidgets -bool false || exit 1
echo "iPhone widgets disabled"

# Spotlight: Disable unwanted categories
# We keep APPLICATIONS, SYSTEM_PREFS, and DIRECTORIES
defaults write com.apple.spotlight orderedItems -array \
	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
	'{"enabled" = 0;"name" = "DIRECTORIES";}' \
	'{"enabled" = 0;"name" = "CALCULATOR";}' \
	'{"enabled" = 0;"name" = "CONTACTS";}' \
	'{"enabled" = 0;"name" = "CONVERSION";}' \
	'{"enabled" = 0;"name" = "DEFINITION";}' \
	'{"enabled" = 0;"name" = "DOCUMENTS_ITEMS";}' \
	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
	'{"enabled" = 0;"name" = "FOLDERS";}' \
	'{"enabled" = 0;"name" = "FONTS";}' \
	'{"enabled" = 0;"name" = "IMAGES";}' \
	'{"enabled" = 0;"name" = "MESSAGES";}' \
	'{"enabled" = 0;"name" = "MOVIES";}' \
	'{"enabled" = 0;"name" = "MUSIC";}' \
	'{"enabled" = 0;"name" = "OTHER";}' \
	'{"enabled" = 0;"name" = "PDF";}' \
	'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
	'{"enabled" = 0;"name" = "SIRI_SUGGESTIONS";}' \
	'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
	'{"enabled" = 0;"name" = "TIPS";}' \
	'{"enabled" = 0;"name" = "WEBSITES";}' || exit 1
echo "Spotlight categories refined"

# Spotlight: Hide icon from menu bar
defaults write com.apple.Spotlight "NSStatusItem Visible Item-0" -bool false || exit 1
echo "Spotlight menu bar icon hidden"

# Control Center & Menu Bar visibility
# Battery: Show in Control Center
defaults -currentHost write com.apple.controlcenter Battery -int 1 || exit 1
# WiFi: Don't show in Menu Bar
defaults -currentHost write com.apple.controlcenter WiFi -int 8 || exit 1
# Bluetooth: Don't show in Menu Bar
defaults -currentHost write com.apple.controlcenter Bluetooth -int 8 || exit 1
# Focus: Don't show in Menu Bar
defaults -currentHost write com.apple.controlcenter FocusModes -int 8 || exit 1
# Now Playing: Don't show in Menu Bar
defaults -currentHost write com.apple.controlcenter NowPlaying -int 8 || exit 1
echo "Control Center and Menu Bar visibility updated"

# Set the Dock tile size and orientation
defaults write com.apple.dock tilesize -int 22 || exit 1
echo "Dock tile size set"
defaults write com.apple.dock orientation -string 'right' || exit 1
echo "Dock orientation set to right"

# Show indicators for open applications
defaults write com.apple.dock show-process-indicators -bool true || exit 1
echo "Enabled Dock process indicators"

# Don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false || exit 1
echo "Disabled automatic Space rearrangement"

# Disable all hot corners
defaults write com.apple.dock wvous-tl-corner -int 0 || exit 1
echo "Disabled hot corner (top-left)"
defaults write com.apple.dock wvous-tr-corner -int 0 || exit 1
echo "Disabled hot corner (top-right)"
defaults write com.apple.dock wvous-bl-corner -int 0 || exit 1
echo "Disabled hot corner (bottom-left)"
defaults write com.apple.dock wvous-br-corner -int 0 || exit 1
echo "Disabled hot corner (bottom-right)"

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1 || exit 1
echo "Mission Control animation duration set"

# Enable Dock auto-hide and set delays to 0 for instant response
defaults write com.apple.dock autohide -bool true || exit 1
echo "Dock auto-hide enabled"
defaults write com.apple.dock autohide-delay -float 0 || exit 1
echo "Dock auto-hide delay set to 0"
defaults write com.apple.dock autohide-time-modifier -float 0 || exit 1
echo "Dock auto-hide animation speed set to 0"

echo "Dock and Mission Control configured (Auto-hide enabled, animations sped up)"

echo "=== Miscellaneous Settings ==="
# Set the custom Hammerspoon config file path
defaults write org.hammerspoon.Hammerspoon MJConfigFile -string "~/.config/.hammerspoon/init.lua" || exit 1

# Disable automatic capitalization, dash substitution, etc. globally
defaults write -g NSAutomaticCapitalizationEnabled -bool false || exit 1
echo "Disabled automatic capitalization"
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false || exit 1
echo "Disabled automatic dash substitution"
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false || exit 1
echo "Disabled automatic period substitution"
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false || exit 1
echo "Disabled automatic quote substitution"
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false || exit 1
echo "Disabled automatic spelling correction"
defaults write -g NSAutomaticTextCompletionEnabled -bool false || exit 1
echo "Disabled automatic text completion"

# Set Activity Monitor to show all processes (category 0)
defaults write com.apple.ActivityMonitor ShowCategory -int 0 || exit 1

# Set custom login window text
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "I AM SERIOUS" || exit 1

# Disable the firewall from automatically allowing signed/downloaded software
sudo defaults write /Library/Preferences/com.apple.alf allowdownloadsignedenabled -bool false || true
sudo defaults write /Library/Preferences/com.apple.alf allowsignedenabled -bool false || true

# Disable console access from the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow DisableConsoleAccess -bool true || exit 1

# Set display sleep timer to 5 minutes on AC power
sudo /usr/libexec/PlistBuddy -c "Set 'AC Power':'Display Sleep Timer' 5" /Library/Preferences/com.apple.PowerManagement.plist 2>/dev/null ||
	sudo /usr/libexec/PlistBuddy -c "Add 'AC Power':'Display Sleep Timer' integer 5" /Library/Preferences/com.apple.PowerManagement.plist || exit 1

# Default to saving new documents to disk instead of iCloud
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false || exit 1
echo "Default save location set to disk"

# Set TextEdit to default to plain text mode
defaults write com.apple.TextEdit RichText -int 0 || exit 1
echo "TextEdit set to plain text mode"

# Disable the Crash Reporter dialog
defaults write com.apple.CrashReporter DialogType -string "none" || exit 1
echo "Disabled Crash Reporter dialog"

# Enable subpixel font smoothing on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2 || exit 1
echo "Enabled font smoothing"

# Prevent Time Machine from creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true || exit 1
echo "Disabled .DS_Store creation on network stores"
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true || exit 1
echo "Disabled .DS_Store creation on USB stores"

# Disable the sudden motion sensor (not useful for SSDs)
sudo pmset -a sms 0 || exit 1

echo "=== Privacy & Siri ==="
# Disable Siri and its associated services
defaults write com.apple.assistant.support "Assistant Enabled" -bool false || exit 1
echo "Disabled Siri Assistant"
defaults write com.apple.assistant.backedup "Use Device Speaker For Alerts" -int 0 || exit 1
echo "Disabled Siri speaker for alerts"
defaults write com.apple.Siri StatusMenuVisible -bool false || exit 1
echo "Hidden Siri status menu"
defaults write com.apple.Siri UserHasDeclinedEnable -bool true || exit 1
echo "User declined Siri enablement set"
echo "Siri disabled"

# Disable Apple personalized advertising
defaults write com.apple.AdLib allowApplePersonalizedAdvertising -int 0 || exit 1
echo "Disabled Apple personalized ads"

# Disable automatic submission of diagnostic data
sudo defaults write "/Library/Application Support/CrashReporter/DiagnosticMessagesHistory.plist" AutoSubmit -bool false || true
sudo chmod 644 "/Library/Application Support/CrashReporter/DiagnosticMessagesHistory.plist" || true
sudo chgrp admin "/Library/Application Support/CrashReporter/DiagnosticMessagesHistory.plist" || true
echo "Diagnostic data auto-submission disabled"

echo "Miscellaneous tweaks applied"

echo "=== Window Manager & Widgets ==="
# Disable desktop widgets and the "click wallpaper to show widgets" feature (Sonoma+)
defaults write com.apple.WindowManager StandardHideWidgets -bool true || exit 1
echo "Hiding widgets in standard view"
defaults write com.apple.WindowManager StageManagerHideWidgets -bool true || exit 1
echo "Hiding widgets in Stage Manager"
defaults write com.apple.WindowManager ClickWidgetBackground -bool false || exit 1
echo "Disabled click wallpaper to show widgets"
defaults write com.apple.WindowManager ShowWidgets -bool false || exit 1
echo "Disabled WindowManager widgets"
defaults write com.apple.widgets AllowWidgets -bool false || exit 1
echo "Disabled widgets entirely"

echo "=== Spotlight Preferences ==="
# Configure Spotlight search results: enable Applications and Expressions, disable the rest
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
echo "Spotlight categories configured"
echo "Spotlight preferences set"

echo "=== Finishup and Cleanup ==="
killall "SystemUIServer" >/dev/null 2>&1 || true
echo "Restarted SystemUIServer"

killall "Finder" >/dev/null 2>&1 || true
echo "Restarted Finder"

killall "Dock" >/dev/null 2>&1 || true
echo "Restarted Dock"

killall "ControlCenter" >/dev/null 2>&1 || true
echo "Restarted ControlCenter"

killall "NotificationCenter" >/dev/null 2>&1 || true
echo "Restarted NotificationCenter"

killall mds >/dev/null 2>&1 || true
echo "Restarted Spotlight daemon"

sudo mdutil -i -a off / >/dev/null 2>&1 || true
echo "Disabled Spotlight indexing on main volume"

sudo mdutil -E / >/dev/null 2>&1 || true
echo "Rebuilt Spotlight index"

killall "cfprefsd" >/dev/null 2>&1 || true
echo "Killed cached preferences daemon"

echo ""
echo "======================================================"
echo "ACTION REQUIRED: Keyboard Shortcuts"
echo "======================================================"
echo "Please manually turn off ALL keyboard shortcuts EXCEPT:"
echo "  - Move focus to next window (⌘ + \`)"
echo "  - Spotlight search (⌘ + Space)"
echo "System Settings has been opened for you."
echo "======================================================"
open "x-apple.systempreferences:com.apple.preference.keyboard?shortcuts"

echo ""
echo "┌────────────────────────┐"
echo "│                        │"
echo "│  You probably want to  │"
echo "│  restart your machine  │"
echo "│       now....          │"
echo "│                        │"
echo "└────────────────────────┘"
echo ""
