VERSION="0.1" 

ask_for_sudo

SILENT=""
if [[ $1 = '--silent' ]]; then
  SILENT=" > /dev/null 2>&1"
fi

_=$(command -v curl)
if [ "$?" != 0 ]; then
  proclaim "Curl is a must"
  eval "apt update $SILENT"
  eval "apt install -y curl $SILENT"
  print_success "Curl is now ready"
fi

APTINSTALLS="apt install -y"
APTINSTALLS="${APTINSTALLS} apt-transport-https ca-certificates build-essential"
APTINSTALLS="${APTINSTALLS} software-properties-common"
APTINSTALLS="${APTINSTALLS} vim git htop ncdu ack tree"
APTINSTALLS="${APTINSTALLS} shutter unclutter"
APTINSTALLS="${APTINSTALLS} google-chrome-stable docker-ce"

SNAPINSTALLS=()
SNAPINSTALLS+=("slack --classic")

proclaim "Injecting apt-repo keys"
curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
print_success "Injected apt-repo keys"
_=`grep -q "dl.google.com/linux/chrome/deb" /etc/apt/sources.list.d/google-chrome.list`
if [ $? != 0 ]; then
  proclaim "Injecting Chrome apt-repo"
  echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
  print_success "Injected Chrome apt-repo"
fi

_=`grep -q "download.docker.com/linux/ubuntu" /etc/apt/sources.list`
if [ $? != 0 ]; then
  proclaim "Injecting Docker apt-repo"
  echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" >> /etc/apt/sources.list
  print_success "Injected Docker apt-repo"
fi

proclaim "Injecting .vimrc .bash_aliases .xinitrc terminalrc"
cd ~
[ -e .vimrc ] && rm -f .vimrc
[ -e .bash_aliases ] && rm -f .bash_aliases
[ -e .xinitrc ] && rm -f .xinitrc
[ -f .config/xfce/terminal ] && mkdir -p .config/xfce/terminal
[ -e .config/xfce/terminal/terminalrc ] && rm .config/xfce/terminal/terminalrc
eval "wget https://raw.githubusercontent.com/unamatasanatarai/dotfiles/master/.vimrc $SILENT"
eval "wget https://raw.githubusercontent.com/unamatasanatarai/dotfiles/master/.bash_aliases $SILENT"
eval "wget https://raw.githubusercontent.com/unamatasanatarai/dotfiles/master/.xinitrc $SILENT"
cd ~/.config/xfce/terminal/
eval "wget https://raw.githubusercontent.com/unamatasanatarai/dotfiles/master/.config/xfce/terminal/terminalrc $SILENT"
cd ~
print_success "Injected .vimrc .bash_aliases .xinitrc terminalrc"

proclaim "apt update"
eval "apt update $SILENT"
print_success "apt update"

proclaim "$APTINSTALLS"
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

proclaim "Fixing Edit mode in Shutter"
mkdir /tmp/shutter/
cd /tmp/shutter/
eval "wget https://launchpad.net/ubuntu/+archive/primary/+files/libgoocanvas-common_1.0.0-1_all.deb $SILENT"
eval "wget https://launchpad.net/ubuntu/+archive/primary/+files/libgoocanvas3_1.0.0-1_amd64.deb $SILENT"
eval "wget https://launchpad.net/ubuntu/+archive/primary/+files/libgoo-canvas-perl_0.06-2ubuntu3_amd64.deb $SILENT"

eval "sudo dpkg -i libgoocanvas-common_1.0.0-1_all.deb $SILENT"
eval "sudo apt -y -f install $SILENT"
eval "sudo dpkg -i libgoocanvas3_1.0.0-1_amd64.deb $SILENT"
eval "sudo apt -y -f install $SILENT"
eval "sudo dpkg -i libgoo-canvas-perl_0.06-2ubuntu3_amd64.deb $SILENT"
eval "sudo apt -y -f install $SILENT"

cd ~
rm -rf /tmp/shutter
print_success "Fixed edit mode in Shutter"

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
