# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew update

# install my apps
brew cask install iterm2 brave-browser lulu sublime-text bitbar eloston-chromium tor-browser keepassxc

# install my tools
brew install vim htop curl wget git tmux ack bash node yarn mariadb apache2 fzf freetype

brew update
brew upgrade
brew upgrade --cask
brew cleanup

# Install check cpu temp binary
cd ~/bin
git clone https://github.com/lavoiesl/osx-cpu-temp.git cpu-temp
cd cpu-temp
make
cd ..
mv cpu-temp/osx-cpu-temp ./
rm -rf cpu-temp
defaults write com.matryer.BitBar pluginsDirectory -string "~/bin/bitbar"
