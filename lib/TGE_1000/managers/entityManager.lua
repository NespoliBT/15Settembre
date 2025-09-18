local Object = require "lib/TGE_1000/libraries/classic"
local EntityManager = Object:extend()

local entities = {}

function EntityManager:new()

end

function EntityManager:addEntity(entity)
    table.insert(entities, entity)
end

function EntityManager:update(dt)
    for _, entity in ipairs(entities) do
        entity:update(dt)
    end
end

-- gotta do dis in layers somehow
function EntityManager:draw()
    for _, entity in ipairs(entities) do
        entity:draw()
    end
end

function EntityManager:getEntities()
    return entities
end

return EntityManager
