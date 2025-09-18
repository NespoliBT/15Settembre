local Entity = require "lib/TGE_1000/entities/entity"
local EntityManager = require "lib/TGE_1000/managers/entityManager"
local SolidEntity = Entity:extend()
local format = require "lib/TGE_1000/utilities/format"
local config = require "lib/TGE_1000/data/config"

function SolidEntity:new(x, y, width, height, properties)
    SolidEntity.super.new(self, x, y, width, height, properties)
    self.name = "SolidEntity"
    self.speedY = 0
    self.speedX = 0
    self.solid = true
    self.collidedWith = nil
    self.collisions = {false, false, false, false}

    self.entityManager = EntityManager()
end

function SolidEntity:update(dt)
    SolidEntity.super.update(self, dt)

    if self.properties.gravity and not self.collisions[2] then
        self.speedY = (self.speedY or 0) + self.properties.gravity * dt
    end
    
    self.entities = self.entityManager:getEntities() or {}

    self.startY = self.startY + (self.speedY or 0) * dt
    self.startX = self.startX + (self.speedX or 0) * dt
    self:checkCollisions()
    if self.collisions[2] or self.collisions[1] then
        self.speedY = 0
    end
    if self.collisions[3] or self.collisions[4] then
        self.speedX = 0
    end 
end

function SolidEntity:checkCollisions()
    self.collisions = {false, false, false, false}
    self.collidedWith = nil

    for _, entity in pairs(self.entities) do
        if self ~= entity and entity.solid then
            self:collidesWith(entity) 
        end
    end
end

function SolidEntity:collidesWith(entity)
    if self.x < entity.x + entity.width and
       self.x + self.width > entity.x and
       self.y < entity.y + entity.height and
       self.y + self.height > entity.y then
        
        local overlapX = math.min(self.x + self.width - entity.x, entity.x + entity.width - self.x)
        local overlapY = math.min(self.y + self.height - entity.y, entity.y + entity.height - self.y)
        
        self.collidedWith = entity
        if overlapX < overlapY then
            if self.x < entity.x then
                self:handleCollision(entity, "right")
            else
                self:handleCollision(entity, "left")
            end
        else
            if self.y < entity.y then
                self:handleCollision(entity, "bottom")
            else
                self:handleCollision(entity, "top")
            end
        end

        if config.debug.collisions then
            love.graphics.setColor(format.hexToRGBA("#ff0000aa"))
            local overlapXStart = math.max(self.x, entity.x)
            local overlapYStart = math.max(self.y, entity.y)
            love.graphics.rectangle("fill", overlapXStart, overlapYStart, overlapX, overlapY)
            love.graphics.setColor(1, 1, 1, 1)
        end
    end
end

function SolidEntity:handleCollision(other, direction)
    if direction == "bottom" then
        self.y = other.y - self.height
        self.collisions[2] = true
    elseif direction == "top" then
        self.y = other.y + other.height
        self.collisions[1] = true
    elseif direction == "left" then
        self.x = other.x + other.width
        self.collisions[3] = true
    elseif direction == "right" then
        self.x = other.x - self.width
        self.collisions[4] = true
    end
end

function SolidEntity:draw()
    SolidEntity.super.draw(self)
    
    if(config.debug.collisions) then
        self.debugInfo[#self.debugInfo + 1] = "Name: " .. (self.name or 0)

        for i, collision in ipairs(self.collisions) do
            local directions = {"top", "bottom", "left", "right"}

            love.graphics.setColor(format.hexToRGBA("#ff0000ff"))
            if directions[i] and collision then
                self.debugInfo[#self.debugInfo + 1] = "Colliding " .. directions[i]
            end

            if directions[i] == "bottom" and collision then
                love.graphics.rectangle("fill", self.x, self.y + self.height - 1, self.width, 2)
            end
            if directions[i] == "top" and collision then
                love.graphics.rectangle("fill", self.x, self.y, self.width, 2)
            end
            if directions[i] == "left" and collision then
                love.graphics.rectangle("fill", self.x, self.y, 2, self.height)
            end
            if directions[i] == "right" and collision then
                love.graphics.rectangle("fill", self.x + self.width - 1, self.y, 2, self.height)
            end
        end
    end
end

return SolidEntity