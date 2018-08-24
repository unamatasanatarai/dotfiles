VERSION="0.1" ask_for_sudo

APTINSTALLS="apt install -y"
APTINSTALLS="${APTINSTALLS} apt-transport-https ca-certificates build-essential"
APTINSTALLS="${APTINSTALLS} software-properties-common"
APTINSTALLS="${APTINSTALLS} curl vim git htop ncdu ack shutter"
APTINSTALLS="${APTINSTALLS} google-chrome-stable docker-ce"

SNAPINSTALLS="snap install slack --classic"

proclaim "Inserting important apt-repos"
curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
if grep -q "dl.google.com/linux/chrome/deb" /etc/apt/sources.list ; then
  echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list
fi
if grep -q "download.docker.com/linux/ubuntu" /etc/apt/sources.list ; then
  echo "deb https://download.docker.com/linux/ubuntu bionic stable" >> /etc/apt/sources.list
fi

proclaim "Injecting .vimrc .bash_aliases"
cd ~
[ -e .vimrc ] && rm -f .vimrc
[ -e .bash_aliases ] && rm -f .bash_aliases
wget https://raw.githubusercontent.com/unamatasanatarai/dotfiles/master/.vimrc
wget https://raw.githubusercontent.com/unamatasanatarai/dotfiles/master/.bash_aliases
print_success "Injected .vimrc .bash_aliases"

apt update
proclaim "$APTINSTALLS"
$APTINSTALLS
print_success "$APTINSTALLS"

proclaim "$SNAPINSTALLS"
$SNAPINSTALLS
print_success "$SNAPINSTALLS"
apt -y full-upgrade

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
