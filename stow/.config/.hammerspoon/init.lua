--defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
-- 
hs.hotkey.bind({"cmd", "alt"}, "W", function()
  hs.alert.show("Hello World!")
  hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
end)
--

-- system_profiler -listDataTypes
-- system_profiler SPUSBDataType
-- system_profiler SPBluetoothDataType
--local FR = require('foundation_remapping')
--local logiremap = FR.new ( { vendorID = 0x046d, productID = 0xc52b })
--logiremap:remap("rcmd", "ralt")
--logiremap:register()

