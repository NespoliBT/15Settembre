local EventBox = require "lib/TGE_1000/ui/eventBox"
local Button = EventBox:extend()

function Button:new(x, y, width, height, child, callback) 
    Button.super.new(self, x, y, width, height, child, "hover")
    self.callback = callback
end

return Button