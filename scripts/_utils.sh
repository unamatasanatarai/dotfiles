#!/usr/bin/env bash

##
# Common script functions
##

inform_about_sudo() {
  local is_sudo=$(sudo -n -v 2>&1);test -z "$A" || echo $A|grep -q asswor
  if [ ! -z "$is_sudo" ]; then
    inform "Some commands require sudo."
  fi
  sudo -v
}

say() {
  echo -en "$1"
}

say_done() {
  say "\033[0;32mdone\033[0m\n"
}

inform() {
  echo -e "\n ⚡  \033[0;36m${1}\033[0m\n"
}

