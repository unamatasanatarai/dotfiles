#!/usr/bin/env bash
VERSION="0.1"

# load utilities for shorthand calls and making things pretty
cd "$(dirname "${BASH_SOURCE[0]}")" \
&& . "utils.sh"

if [ "$EUID" -ne 0 ]; then
  print_in_red "sudo ? please ?\n"
fi

apt update
apt -y full-upgrade
apt install -y vim git

