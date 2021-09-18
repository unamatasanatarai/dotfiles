#!/usr/bin/env python3

import os
import json

os.system("/usr/local/bin/yabai -m query --spaces > /tmp/yabai_spaces.app")
with open("/tmp/yabai_spaces.app", "r") as f:
    spaces = json.loads(f.read())

unfocused = "⬜"
focused = "⬛"

display = ""
for space in spaces:
    display += focused if space['focused'] else unfocused

print(display)
