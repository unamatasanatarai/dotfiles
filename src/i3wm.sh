#!/usr/bin/env bash
# apt install -y i3
. ./utils.sh

CONFIG="~/.config/i3/config"

# Variabilize workspace names
_=`grep -q 'variable workspace names' ~/.config/i3/config`
if [ $? != 0 ]; then
  eval "sed -i 's/# switch to workspace/# variable workspace names\n# switch to workspace/g' ${CONFIG}"
fi

variabilizeWorkspace() {
  local WKEY=$1
  local WNUM=$WKEY
  if [ $WKEY = 0 ]; then
    WNUM=10
  fi
  local WNAME=$2
  proclaim "Replacing name of workspace ${WNAME}"
  C='grep -q "set \$workspace${WKEY}" ~/.config/i3/config'
  eval $C
  if [ $? != 0 ]; then
    eval "sed -i 's/# switch to workspace/set \$workspace${WKEY} \"${WNAME}\"\n# switch to workspace/g' ${CONFIG}"
  fi
  eval "sed -i 's/bindsym \$mod+${WKEY} workspace ${WNUM}/bindsym \$mod+${WKEY} workspace \$workspace${WKEY}/g' ${CONFIG}"
  eval "sed -i 's/bindsym \$mod+Shift+${WKEY} move container to workspace ${WNUM}/bindsym \$mod+Shift+${WKEY} move container to workspace \$workspace${WKEY}/g' ${CONFIG}"
  print_success "Replaced name of workspace ${WNAME}"
}

variabilizeWorkspace 0 "Other"
variabilizeWorkspace 1 "1: "
variabilizeWorkspace 2 "2: "
variabilizeWorkspace 3 "3: "

sed -i "s/status_command i3status/position top\n        status_command i3status/g" ~/.config/i3/config
echo "assign [class=\"Slack\"] \$workspace2" >> ~/.config/i3/config
echo "assign [class=\"Google-chrome\"] \$workspace1" >> ~/.config/i3/config
echo "assign [class=\"Gnome-terminal\"] \$workspace3" >> ~/.config/i3/config
echo "hide_edge_borders both" >> ~/.config/i3/config
echo "exec slack" >> ~/.config/i3/config
echo "exec google-chrome" >> ~/.config/i3/config
echo "focus_follows_mouse no" >> ~/.config/i3/config

[ -f ~/.fonts ] && mkdir ~/.fonts
cd ~/.fonts
wget https://github.com/unamatasanatarai/dotfiles/raw/master/fonts/Font%20Awesome%205%20Free-Solid-900.otf
wget https://github.com/unamatasanatarai/dotfiles/raw/master/fonts/Font%20Awesome%205%20Free-Regular-400.otf
wget https://github.com/unamatasanatarai/dotfiles/raw/master/fonts/Font%20Awesome%205%20Brands-Regular-400.otf

print_in_yellow "
DONE!
"
