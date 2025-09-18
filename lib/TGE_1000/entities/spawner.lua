local config = require "lib/TGE_1000/data/config"
local format = require "lib/TGE_1000/utilities/format"
local EntityManager = require "lib/TGE_1000/managers/entityManager"

local Entity = require "lib/TGE_1000/entities/entity"
local Spawner = Entity:extend()

function Spawner:new(x, y, width, height, properties)
    Spawner.super.new(self, x, y, width, height, properties)
    self.name = "Spawner"
    self.spawnedEntities = {}
    self.properties = properties or {}
    self.spawnInterval = tonumber(self.properties.spawnInterval) or 2
    self.timeSinceLastSpawn = 0
    self.maxSpawns = tonumber(self.properties.maxSpawns)
    self.entityType = self.properties.entityType or Entity
    self.entityManager = EntityManager()

    self.properties.entityType = properties.entityType or Entity
    self.properties.entityParams = properties.entityParams or {}
    self.properties.entityProps = properties.entityProps or {}
end

function Spawner:update(dt)
    Spawner.super.update(self, dt)

    self.timeSinceLastSpawn = self.timeSinceLastSpawn + dt
    if self.timeSinceLastSpawn >= self.spawnInterval and (#self.spawnedEntities < self.maxSpawns or self.maxSpawns == 0) then
        self:spawnEntity()
        self.timeSinceLastSpawn = 0
    end

    for i = #self.spawnedEntities, 1, -1 do
        local entity = self.spawnedEntities[i]
        if entity.isDestroyed then
            table.remove(self.spawnedEntities, i)
        else
            entity:update(dt)
        end
    end
end

function Spawner:draw()
    Spawner.super.draw(self)
    for _, entity in ipairs(self.spawnedEntities) do
        entity:draw()
    end

    if config.debug.spawners then
        love.graphics.setColor(format.hexToRGBA("#ffff00ff"))
        love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
        love.graphics.setColor(1, 1, 1, 1)
    end
end

function Spawner:spawnEntity()
    local entity_x = self.startX
    local entity_y = self.startY
    local entityProps = self.properties.entityProps or {}

    self.properties.entityParams = {
        entity_x, entity_y, nil, nil, entityProps
    }

    local entity = entityClass(unpack(self.properties.entityParams))
    self.entityManager:addEntity(entity)
    table.insert(self.spawnedEntities, entity)
end

return Spawner