#!/usr/bin/env bash
ROOT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

ask_for_sudo() {
  if [ "$EUID" -ne 0 ]; then
    print_question "Do you sudo\n"
    exit 1
  fi
}

print_error() {
    print_in_red "   [✖] $1 $2"
}

print_in_color() {
    printf "%b" \
        "$(tput setaf "$2" 2> /dev/null)" \
        "$1" \
        "$(tput sgr0 2> /dev/null)"
}

print_in_green() {
    print_in_color "$1" 2
}

print_in_red() {
    print_in_color "$1" 1
}

print_in_yellow() {
    print_in_color "$1" 3
}

print_question() {
    print_in_yellow "   [?] $1"
}

print_success() {
    print_in_green "   [✔] $1"
}

proclaim() {
    print_in_yellow "\n   [!] $1"
}

VERSION="0.1" ask_for_sudo

SILENT=""
if [[ $1 = '--silent' ]]; then
  SILENT=" > /dev/null 2>&1"
fi

APTINSTALLS="apt install -y"
APTINSTALLS="${APTINSTALLS} apt-transport-https ca-certificates build-essential"
APTINSTALLS="${APTINSTALLS} software-properties-common"
APTINSTALLS="${APTINSTALLS} curl vim git htop ncdu ack shutter"
APTINSTALLS="${APTINSTALLS} google-chrome-stable docker-ce"

SNAPINSTALLS=()
SNAPINSTALLS+=("slack --classic")
SNAPINSTALLS+=("skype")

proclaim "Injecting apt-repo keys"
curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
print_success "Injected apt-repo keys"
_=`grep -q "dl.google.com/linux/chrome/deb" /etc/apt/sources.list`
if [ $? != 0 ]; then
  proclaim "Injecting Chrome apt-repo"
  echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list
  print_success "Injected Chrome apt-repo"
fi

_=`grep -q "download.docker.com/linux/ubuntu" /etc/apt/sources.list`
if [ $? != 0 ]; then
  proclaim "Injecting Docker apt-repo"
  echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" >> /etc/apt/sources.list
  print_success "Injected Docker apt-repo"
fi

proclaim "Injecting .vimrc .bash_aliases"
cd ~
[ -e .vimrc ] && rm -f .vimrc
[ -e .bash_aliases ] && rm -f .bash_aliases
eval "wget https://raw.githubusercontent.com/unamatasanatarai/dotfiles/master/.vimrc $SILENT"
eval "wget https://raw.githubusercontent.com/unamatasanatarai/dotfiles/master/.bash_aliases $SILENT"
print_success "Injected .vimrc .bash_aliases"

proclaim "apt update"
eval "apt update $SILENT"
print_success "apt update"

proclaim "$APTINSTALLS $SILENT"
eval "${APTINSTALLS} ${SILENT}"
print_success "$APTINSTALLS"

proclaim "$SNAPINSTALLS"
for item in "${SNAPINSTALLS[@]}"
do
  proclaim "snap install ${item}"
  eval "snap install $item $SILENT"
  if [ "$?" != 0 ]; then
    print_error "${item}"
  else
    print_success "${item}"
  fi
done

_=$(command -v docker-compose)
if [ "$?" != 0 ]; then
  proclaim "Installing docker-compose"
  eval "curl -sL https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose"
  chmod +x /usr/local/bin/docker-compose
  print_success "Installed docker-compose"
fi

proclaim "Full system upgrade"
eval "apt update $SILENT"
eval "apt -y full-upgrade $SILENT"
print_success "Full system upgrade"

proclaim "Autocleanup apt"
eval "apt autoremove -y $SILENT"
print_success "Cleandup apt"

print_in_yellow "

···············
· I ♥M H♥PPY! ·
···············
"
