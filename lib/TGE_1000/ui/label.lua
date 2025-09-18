local Text = require "lib/TGE_1000/ui/text"
local Object = require "lib/TGE_1000/libraries/classic"
local Label = Object:extend()

function Label:new(x, y, width, height, label)
    self.startX = x
    self.startY = y
    self.startWidth = width
    self.startHeight = height
    self.label = label
    self.text = Text(x, y, label, nil, nil, self.width)
end

function Label:update()

end

function Label:draw()

end

return Label