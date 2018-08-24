VERSION="0.1"

ask_for_sudo

proclaim "Injecting .vimrc .bash_aliases"
cd ~
[ -e .vimrc ] && rm -f .vimrc
[ -e .bash_aliases ] && rm -f .bash_aliases
wget https://raw.githubusercontent.com/unamatasanatarai/dotfiles/master/.vimrc
wget https://raw.githubusercontent.com/unamatasanatarai/dotfiles/master/.bash_aliases
print_success "Injected .vimrc .bash_aliases"

apt update
apt -y full-upgrade

proclaim "Installing bare necessities"
apt install -y apt-transport-https ca-certificates \
  build-essential \
  curl software-properties-common vim git htop ncdu ack shutter
print_success "Installed bare minimum"

_=$(command -v slack)
if [ "$?" != 0 ]; then
  proclaim "Installing Slack"
  snap install slack --classic
  print_success "Slack installed"
fi

_=$(command -v google-chrome)
if [ "$?" != 0 ]; then
  proclaim "Adding Chrome apt-repo"
  curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
  add-apt-repository "deb https://dl.google.com/linux/chrome/deb/ stable main"
  print_success "Added Chrome apt-repo"

  apt update

  proclaim "Installing Chrome"
  apt install -y google-chrome-stable
  proclaim "Installed Chrome"
fi

_=$(command -v docker)
if [ "$?" != 0 ]; then
  proclaim "Adding Docker apt-repo"
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
  print_success "Added Docker apt-repo"

  apt update

  proclaim "Installing Docker"
  apt install -y docker-ce
  print_success "Installed docker"
fi

_=$(command -v docker-compose)
if [ "$?" != 0 ]; then
  proclaim "Installing docker-compose"
  curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  print_success "Installed docker-compose"
fi

proclaim "Autocleanup apt"
apt autoremove -y
print_success "Cleandup apt"
