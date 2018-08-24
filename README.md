# dotfiles
Because installing things is rarely fun

## Compiling a new script
Make changes only in the source files located in `/src` folder.

Then recompile by running:
./src/make_ubuntu.sh

## Installation and usage on a new machine
NEVER run scripts directly from the internets. So, 

```
wget https://raw.githubusercontent.com/unamatasanatarai/dotfiles/master/ubuntu.sh
chmod +x ubuntu.sh
sudo ./ubuntu.sh
```

## What does it do?

1. `full-upgrade` your system.
1. update vim
1. inject .vimrc
1. inject .bash_aliases
1. install
    - ack
    - shutter
    - slack
    - chrome
    - git
    - curl
    - htop
    - ncdu
    - docker
    - docker-compose

