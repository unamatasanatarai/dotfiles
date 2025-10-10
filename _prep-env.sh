#!/usr/bin/env bash

#at the moment of installation, bash is not yet configured. So import the defaults
source configs/dot-config/bash/src/settings
LOCAL_BIN="$HOME/.local/bin"
BASH_DATA_HOME="$XDG_DATA_HOME/bash"

dir_vars=(
  BASH_DATA_HOME
  LOCAL_BIN
  XDG_CACHE_HOME
  XDG_CONFIG_HOME
  XDG_DATA_HOME
  XDG_DESKTOP_DIR
  XDG_DOWNLOAD_DIR
  XDG_STATE_HOME
)

for var in "${dir_vars[@]}"; do
  dir="${!var}"
  mkdir -vp "$dir"
done

