local world = require "data/world"
local format = require "lib/TGE_1000/utilities/format"
local SolidEntity = require "lib/TGE_1000/entities/solidEntity"
local Cube = SolidEntity:extend()

function Cube:new(x, y, width, height, properties)
    local x = x or 0
    local y = y or 0
    local width = width or 5
    local height = height or 5
    local properties = properties or {
        gravity = world.gravity
    }

    Cube.super.new(self, x, y, width, height, properties)

    self.name = "Cube"
end

function Cube:update(dt)
    Cube.super.update(self, dt)
end

function Cube:draw()
    Cube.super.draw(self)
end

return Cube