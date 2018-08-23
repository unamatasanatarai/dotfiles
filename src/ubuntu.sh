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
  curl software-properties-common vim git htop ncdu
print_success "Installed bare minimum"

_=$(command -v docker)
if [ "$?" != 0 ]; then
  proclaim "Adding docker apt-repo"
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
  print_success "Added docker apt-repo"

  apt update

  proclaim "Installing docker"
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
