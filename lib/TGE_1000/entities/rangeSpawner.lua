local config = require "lib/TGE_1000/data/config"
local windowU = require "lib/TGE_1000/utilities/window"
local world = require "data/world"
local format = require "lib/TGE_1000/utilities/format"
local Spawner = require "lib/TGE_1000/entities/spawner"
local Entity = require "lib/TGE_1000/entities/entity"

local RangeSpawner = Spawner:extend()

function RangeSpawner:new(x, y, width, height, properties)
    self.spawnRange = properties.spawnRange or 50
    RangeSpawner.super.new(self, x, y, width, height, properties)
end

function RangeSpawner:spawnEntity()
    local entity_x = self.startX
    local entity_y = self.startY
    local entityProps = self.properties.entityProps or {}
    
    if self.spawnRange > 0 then
        entity_x = entity_x + math.random(-self.spawnRange, self.spawnRange)
        entity_y = entity_y + math.random(-self.spawnRange, self.spawnRange)
    end

    self.properties.entityParams = {
        entity_x, entity_y, nil, nil, entityProps
    }

    local entity = self.entityType(unpack(self.properties.entityParams))
    self.entityManager:addEntity(entity)
    table.insert(self.spawnedEntities, entity)
end

function RangeSpawner:draw()
    RangeSpawner.super.draw(self)

    if config.debug.spawners then 
        love.graphics.setColor(format.hexToRGBA("#00ff008f"))
        local drawRange = windowU.normalize(self.spawnRange, self.spawnRange)
        love.graphics.rectangle("line", self.x - drawRange, self.y - drawRange, self.width + drawRange * 2, self.height + drawRange * 2)
        love.graphics.setColor(1, 1, 1, 1)
    end
end

return RangeSpawner