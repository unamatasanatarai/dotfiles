-- keep your $HOME clean!
-- $ defaults write org.hammerspoon.Hammerspoon MJConfigFile -string "~/.config/.hammerspoon/init.lua"


-- Keyboard remapping for logi ERGO K860 for the Polish Folk!
-- system_profiler -listDataTypes
-- system_profiler SPUSBDataType
-- system_profiler SPBluetoothDataType
local FR = require('foundation_remapping')
local logiremap = FR.new({ vendorID = 0x046D, productID = 0xB359 })
logiremap:remap("rcmd", "ralt")
-- hack for the other computer. The keyboard is acting up on it.
if hs.host.localizedName() == "Decrypted" then
  logiremap:remap("lcmd", "lalt"):remap("lalt", "lcmd")
end
logiremap:register()


-- hs.pathwatcher.new(os.getenv("HOME") .. "/.config/.hammerspoon/", hs.reload):start()
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

-- reload config on non blocking shortcut
-- local function catcher(event)
--   local flags = event:getFlags()
--
--   if flags["ctrl"] and "§" == hs.keycodes.map[event:getKeyCode()] then
--     hs.reload()
--   end
-- end

-- hs.eventtap.new({ hs.eventtap.event.types.keyDown }, catcher):start()
