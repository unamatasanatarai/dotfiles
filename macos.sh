#!/usr/bin/env bash

# Don't show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool false



# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Disable startup sound
sudo nvram SystemAudioVolume="%80"

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable local Time Machine backups
hash tmutil &> /dev/null && sudo tmutil disablelocal

# Keyboard: disable letter popup on hold
defaults write -g ApplePressAndHoldEnabled -bool false

# Keyboard: fast repeat
defaults write -g KeyRepeat -int 1

# Trash: disable warning on empty
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Finder: list view by default
defaults write com.apple.finder FXPreferredViewStyle -string 'Nlsv'

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Set 1 second delay when showing and hiding the Dock (to discourage using the Dock)
defaults write com.apple.dock autohide-delay -float 1 

# Dock: remove all app icons
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock persistent-others -array

# Dock: hidden icons are transparent and small
defaults write com.apple.dock showhidden -bool true
defaults write com.apple.dock tilesize -int 22

# Dock: magnify
defaults write com.apple.dock magnification -int 1
defaults write com.apple.dock largesize -int 50
defaults write com.apple.dock orientation -string 'left'


# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable the sudden motion sensor as it’s not useful for SSDs
sudo pmset -a sms 0

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Show battery percentage
defaults write com.apple.menuextra.battery ShowPercent -string 'YES'

# Quit printer on job done
defaults write com.apple.print.PrintingPrefs 'Quit When Finished' -bool true

# Screenshots: save as png
defaults write com.apple.screencapture type -string 'png'

# Bluetooth: turn off
sudo defaults write /Library/Preferences/com.apple.Bluetooth.plist ControllerPowerState 0
sudo launchctl unload /System/Library/LaunchDaemons/com.apple.blued.plist
sudo launchctl load /System/Library/LaunchDaemons/com.apple.blued.plist

# Brew: install
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Brew: update
brew update
brew upgrade --all
brew install vim --with-override-system-vi
brew install bash tree wget ncdu htop
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
brew cask install iterm2 firefox vlc torbrowser

# Brew: cleanup
brew cleanup
brew cask cleanup

# restart&reload
killall "SystemUIServer" &> /dev/null
killall "Finder" &> /dev/null
killall "cfprefsd" &> /dev/null
killall "Dock" &> /dev/null
