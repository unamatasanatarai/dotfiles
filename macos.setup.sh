# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew update

# install my apps
brew cask install iterm2 brave-browser lulu sublime-text bitbar eloston-chromium tor-browser keepassxc

# install my tools
brew install vim htop curl wget git mysql tmux bash

# we like bash a little more than zsh
chsh -s /bin/bash

# Disable startup sound
sudo nvram SystemAudioVolume="%80"

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Keyboard: disable letter popup on hold
defaults write -g ApplePressAndHoldEnabled -bool false

# Keyboard: fast repeat
defaults write -g KeyRepeat -int 1

# Trash: disable warning on empty
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Dock: remove all app icons
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock persistent-others -array

# Dock: hidden icons are transparent and small
defaults write com.apple.dock showhidden -bool true
defaults write com.apple.dock tilesize -int 22

# Dock: magnify
defaults write com.apple.dock magnification -int 1
defaults write com.apple.dock largesize -int 50

# Dock: position right
defaults write com.apple.dock orientation -string 'right'

# Disable the sudden motion sensor as it’s not useful for SSDs
sudo pmset -a sms 0

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Show battery percentage
defaults write com.apple.menuextra.battery ShowPercent -string 'YES'

# Brew: cleanup
brew cleanup

# restart&reload
killall "SystemUIServer" &> /dev/null
killall "Finder" &> /dev/null
killall "cfprefsd" &> /dev/null
killall "Dock" &> /dev/null


# install some utencils
mkdir ~/bin
cd ~/bin
git clone https://github.com/lavoiesl/osx-cpu-temp.git cpu-temp
cd cpu-temp
make
cd ..
mv cpu-temp/osx-cpu-temp ./
rm -rf cpu-temp
