-- keep your $HOME clean!
-- $ defaults write org.hammerspoon.Hammerspoon MJConfigFile -string "~/.config/.hammerspoon/init.lua"


-- Keyboard remapping for logi ERGO K860 for the Polish Folk!
-- system_profiler -listDataTypes
-- system_profiler SPUSBDataType
-- system_profiler SPBluetoothDataType
local FR = require('foundation_remapping')
local logiremap = FR.new({ vendorID = 0x046D, productID = 0xB359 })
logiremap:remap("rcmd", "ralt")
logiremap:register()


hs.pathwatcher.new(os.getenv("HOME") .. "/.config/.hammerspoon/", hs.reload):start()
hs.alert.show(
  "HS CONFIG RELOADED",
  {
    strokeWidth     = 2,
    strokeColor     = { white = 1, alpha = 0.75 },
    fillColor       = { white = 0, alpha = 0.75 },
    textColor       = { white = 1, alpha = 0.75 },
    textFont        = ".AppleSystemUIFont",
    textSize        = 10,
    radius          = 1,
    atScreenEdge    = 1,
    fadeInDuration  = 0.1,
    fadeOutDuration = 0.1,
    padding         = 1,
  },
  hs.screen.mainScreen(),
  .3
)

hs.hotkey.bind({ "alt", "shift" }, "[", hs.reload)