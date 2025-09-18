local RangeSpawner = require "lib/TGE_1000/entities/rangeSpawner"
local Cube = require "src/entities/cube"

local CubeSpawner = RangeSpawner:extend()

function CubeSpawner:new(x, y, width, height, properties)
    properties.entityType = Cube
    CubeSpawner.super.new(self, x, y, width, height, properties)
end

return CubeSpawner