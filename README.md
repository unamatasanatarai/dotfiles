# dotfiles
Because installing things is rarely fun

## Compiling a new script
Make changes only in the source files located in `/src` folder.

Then recompile by running:
```
./src/make_ubuntu.sh
./src/make_i3wm.sh
```

## Installation and usage on a new machine

### Pure ubuntu

NEVER run scripts directly from the internets. So, 

```
wget https://raw.githubusercontent.com/unamatasanatarai/dotfiles/master/ubuntu.sh
chmod +x ubuntu.sh
sudo ./ubuntu.sh
# or if you do not care about any output
sudo ./ubuntu.sh --silent
```

#### What does it do?

1. `full-upgrade` your system.
1. update vim
1. inject .vimrc
1. inject .bash_aliases
1. install
    - unclutter
    - tree
    - ack
    - shutter
    - slack
    - google-chrome
    - git
    - curl
    - htop
    - ncdu
    - docker
    - docker-compose

### i3wm

NEVER run scripts directly from the internets. So, 

```
wget https://raw.githubusercontent.com/unamatasanatarai/dotfiles/master/i3wm.sh
chmod +x i3wm.sh
sudo ./i3wm.sh
```

## Vim stuff
`<Leader>nu` will toggle numbers, cause sometimes you want to copy and paste with your mouse

`,w` is now `:w<CR>
