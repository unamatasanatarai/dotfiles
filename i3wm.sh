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

sudo add-apt-repository -y -u ppa:snwh/ppa

apt install -y i3 i3blocks arc-theme \
  moka-icon-theme faba-icon-theme faba-mono-icons \
  libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev \
  libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev \
  libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
  libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf \
  libxcb-xrm0 libxcb-xrm-dev automake scrot

proclaim "Create basic directories for i3"
[ -f ~/.config/i3/scripts ] && mkdir -p ~/.config/i3/scripts
[ -f ~/.config/i3blocks ] && mkdir -p ~/.config/i3blocks
[ -f ~/.fonts ] && mkdir ~/.fonts
print_success "Created basic i3 directories"

proclaim "Copy i3 configs"
cd ~/.config/i3/
wget https://github.com/unamatasanatarai/dotfiles/raw/master/.config/i3/config
cd ~/.config/i3blocks/
wget https://github.com/unamatasanatarai/dotfiles/raw/master/.config/i3blocks/i3blocks/conf
print_success "Copied i3 configs"

proclaim "Copy i3 custom scripts"
cd ~/.config/i3/scripts
wget https://github.com/unamatasanatarai/dotfiles/raw/master/.config/i3/scripts/lock.sh
wget https://github.com/unamatasanatarai/dotfiles/raw/master/.config/i3/scripts/lock.png
print_success "Copied 3k custom scripts"

proclaim "Download i3 fonts"
cd ~/.fonts
wget https://github.com/unamatasanatarai/dotfiles/raw/master/.fonts/System\ San\ Francisco\ Display\ Bold.ttf
wget https://github.com/unamatasanatarai/dotfiles/raw/master/.fonts/System\ San\ Francisco\ Display\ Regular.ttf
wget https://github.com/unamatasanatarai/dotfiles/raw/master/.fonts/System\ San\ Francisco\ Display\ Thin.ttf
wget https://github.com/unamatasanatarai/dotfiles/raw/master/.fonts/System\ San\ Francisco\ Display\ Ultralight.ttf
wget https://github.com/unamatasanatarai/dotfiles/raw/master/.fonts/Font\ Awesome\ 5\ Brands-Regular-400.otf
wget https://github.com/unamatasanatarai/dotfiles/raw/master/.fonts/Font\ Awesome\ 5\ Free-Regular-400.otf
wget https://github.com/unamatasanatarai/dotfiles/raw/master/.fonts/Font\ Awesome\ 5\ Free-Solid-900.otf
wget https://github.com/unamatasanatarai/dotfiles/raw/master/.fonts/Hack-Bold.ttf
wget https://github.com/unamatasanatarai/dotfiles/raw/master/.fonts/Hack-BoldItalic.ttf
wget https://github.com/unamatasanatarai/dotfiles/raw/master/.fonts/Hack-Italic.ttf
wget https://github.com/unamatasanatarai/dotfiles/raw/master/.fonts/Hack-Regular.ttf
print_success "Downloaded i3 fonts"

proclaim "Installing i3gaps"
cd /tmp

# clone the repository
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps

# compile & install
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/

# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
make install
print_success "i3gaps should have installed"

print_in_yellow "

···············
· I ♥M H♥PPY! ·
···············
"
