local SolidEntity = require "lib/TGE_1000/entities/solidEntity"
local Platform = SolidEntity:extend()

function Platform:new(x, y, width, height, properties)
    Platform.super.new(self, x, y, width, height, properties)

    self.name = "Platform"
end

function Platform:update(dt)
    Platform.super.update(self, dt)
end

function Platform:draw()
    Platform.super.draw(self)
end

return Platform