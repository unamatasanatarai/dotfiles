echo "install homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "brew update"
brew update

echo "install my apps"
brew cask install iterm2 brave-browser lulu sublime-text bitbar eloston-chromium tor-browser keepassxc kap slack vlc

echo "install my tools"
brew install vim htop curl wget git tmux ack bash node yarn mariadb apache2 fzf freetype

echo "update"
brew update
echo "upgrade"
brew upgrade
echo "upgrade --cask"
brew upgrade --cask
echo "cleanup"
brew cleanup

echo "Install check cpu temp binary"
cd ~/bin
git clone https://github.com/lavoiesl/osx-cpu-temp.git cpu-temp
cd cpu-temp
make
cd ..
mv cpu-temp/osx-cpu-temp ./
rm -rf cpu-temp
defaults write com.matryer.BitBar pluginsDirectory -string "~/bin/bitbar"
