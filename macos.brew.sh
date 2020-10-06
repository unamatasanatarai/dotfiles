# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew update

# install my apps
brew cask install iterm2 brave-browser lulu sublime-text bitbar eloston-chromium tor-browser keepassxc

# install my tools
brew install vim htop curl wget git tmux ack bash node yarn mariadb apache2 fzf

brew upgrade
brew upgrade --cask

# install some utencils
[ ! -d ~/bin ] && mkdir ~/bin
cd ~/bin
git clone https://github.com/lavoiesl/osx-cpu-temp.git cpu-temp
cd cpu-temp
make
cd ..
mv cpu-temp/osx-cpu-temp ./
rm -rf cpu-temp
