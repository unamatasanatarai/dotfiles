VERSION="0.1"

ask_for_sudo

say_in_purple "Injecting .vimrc .bash_aliases"
cd ~
wget https://raw.githubusercontent.com/unamatasanatarai/dotfiles/master/.vimrc
wget https://raw.githubusercontent.com/unamatasanatarai/dotfiles/master/.bash_aliases
print_success

apt update
apt -y full-upgrade
# install stuff to have latest docker
apt install -y apt-transport-https ca-certificates \
  curl software-properties-common vim git

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

apt update

apt install -y docker-ce

