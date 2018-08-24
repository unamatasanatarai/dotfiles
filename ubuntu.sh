#!/usr/bin/env bash
ROOT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

ask_for_sudo() {
  if [ "$EUID" -ne 0 ]; then
    print_question "Do you sudo\n"
    exit 1
  fi
}

answer_is_yes() {
    [[ "$REPLY" =~ ^[Yy]$ ]] \
        && return 0 \
        || return 1
}

ask() {
    print_question "$1"
    read -r
}

ask_for_confirmation() {
    print_question "$1 (y/n) "
    read -r -n 1
    printf "\n"
}

print_error() {
    print_in_red "   [✖] $1 $2\n"
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
    print_in_green "\n\n   [✔] $1\n\n\n"
}

proclaim() {
    print_in_yellow "\n\n   [!] $1\n\n\n"
}

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
