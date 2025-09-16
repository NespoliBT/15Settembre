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

    self.entityManager = EntityManager()
end

function SolidEntity:update(dt)
    SolidEntity.super.update(self, dt)

    if self.properties.gravity then
        self.speedY = (self.speedY or 0) + self.properties.gravity * dt
    end
    
    self.entities = self.entityManager:getEntities() or {}
    self:checkCollisions()
    
    self.startY = self.startY + (self.speedY * dt)
    self.startX = self.startX + (self.speedX * dt)
end

function SolidEntity:checkCollisions()
    if not self.entities then return end

    for _, entity in ipairs(self.entities) do
        local direction = self:collidesWith(entity)
        if direction then
            self:handleCollision(entity, direction)
        end
    end
end

function SolidEntity:collidesWith(other)
    if self == other then return false end

    if self.x < other.x + other.width and
       self.x + self.width > other.x and
       self.y < other.y + other.height and
       self.y + self.height > other.y then

        local overlapX = math.min(self.x + self.width, other.x + other.width) - math.max(self.x, other.x)
        local overlapY = math.min(self.y + self.height, other.y + other.height) - math.max(self.y, other.y)

        if overlapX < overlapY then
            if self.x + self.width / 2 < other.x + other.width / 2 then
                return "left"
            else
                return "right"
            end
        else
            if self.y + self.height / 2 < other.y + other.height / 2 then
                return "top"
            else
                return "bottom"
            end
        end
    end

    return false
end


function SolidEntity:handleCollision(other, direction)
    if direction == "top" and self.speedY > 0 then
        self.y = other.y - self.height
        self.speedY = 0
    end
    if direction == "bottom" and self.speedY < 0 then
        self.y = other.y + other.height
        self.speedY = 0
    end
    if direction == "left" and self.speedX > 0 then
        self.x = other.x - self.width
        self.speedX = 0
    end
    if direction == "right" and self.speedX < 0 then
        self.x = other.x + other.width
        self.speedX = 0
    end
end

function SolidEntity:draw()
    SolidEntity.super.draw(self)
    
    if(config.debug.collisions) then
        self.debugInfo[#self.debugInfo + 1] = "SpeedX: " .. (self.speedX or 0)
        self.debugInfo[#self.debugInfo + 1] = "SpeedY: " .. (self.speedY or 0)
    end
end

return SolidEntity