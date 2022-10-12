-- keep your $HOME clean!
-- $ defaults write org.hammerspoon.Hammerspoon MJConfigFile -string "~/.config/.hammerspoon/init.lua"


-- Keyboard remapping for logi ERGO K860 for the Polish Folk!
-- system_profiler -listDataTypes
-- system_profiler SPUSBDataType
-- system_profiler SPBluetoothDataType
local FR = require('foundation_remapping')
local logiremap = FR.new ( { vendorID = 0x046D, productID = 0xB359 })
logiremap:remap("rcmd", "ralt")
logiremap:register()

