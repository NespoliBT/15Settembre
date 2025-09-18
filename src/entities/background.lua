local Entity = require "lib/TGE_1000/entities/entity"
local format = require "lib/TGE_1000/utilities/format"

local Background = Entity:extend()

function Background:new(x, y, width, height, properties)
    properties = properties or {}
    properties.color = properties.color or format.hexToRGBA("#1c5256ff")

    Background.super.new(self, x, y, width, height, properties)
    self.name = "Background"
end

return Background