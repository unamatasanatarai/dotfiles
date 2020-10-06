echo "we like bash a little more than zsh"
chsh -s /bin/bash

echo "Disable startup sound"
sudo nvram SystemAudioVolume="%80"

echo "Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

echo "Keyboard: disable letter popup on hold"
defaults write -g ApplePressAndHoldEnabled -bool false

echo "Keyboard: fast repeat"
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 15

echo "Finder fine tuning"
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder NewWindowTarget -string PfHm
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "Trash: disable warning on empty"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo "Dock: remove all app icons"
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock persistent-others -array

echo "Dock: hidden icons are transparent and small"
defaults write com.apple.dock showhidden -bool true
defaults write com.apple.dock tilesize -int 22

echo "Dock: magnify"
defaults write com.apple.dock magnification -int 1
defaults write com.apple.dock largesize -int 50

echo "Dock: position right"
defaults write com.apple.dock orientation -string 'right'

echo "Disable the sudden motion sensor as it’s not useful for SSDs"
sudo pmset -a sms 0

echo "Avoid creating .DS_Store files on network or USB volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

echo "Show battery percentage"
defaults write com.apple.menuextra.battery ShowPercent -string 'YES'

echo "restart&reload"
killall "SystemUIServer" &> /dev/null
killall "Finder" &> /dev/null
killall "cfprefsd" &> /dev/null
killall "Dock" &> /dev/null


echo -e "\n\n\033[33m  Logout & Login for some settings to take effect\n"
