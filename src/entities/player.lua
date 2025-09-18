local SolidEntity = require "lib/TGE_1000/entities/solidEntity"
local format = require "lib/TGE_1000/utilities/format"
local world = require "data/world"
local Player = SolidEntity:extend()
local InputManager = require "lib/TGE_1000/managers/inputManager"
local inputManager = InputManager()

function Player:new(x, y, width, height, properties)
    local properties = properties or {}

    Player.super.new(self, x, y, width, height, properties)
    inputManager:bindKey(function() self:move("left") end, {"left", "a"}, "keep")
    inputManager:bindKey(function() self:move("right") end, {"right", "d"}, "keep")
    
    inputManager:bindKey(function() self:stop() end, {"left", "a"}, "release")
    inputManager:bindKey(function() self:stop() end, {"right", "d"}, "release")

    inputManager:bindKey(function() self:move("down") end, {"down", "s"}, "keep")
    inputManager:bindKey(function() self:move("up") end, {"up", "w", "space"}, "keep")
    
    inputManager:bindKey(function() self:stop() end, {"down", "s"}, "release")
    inputManager:bindKey(function() self:stop() end, {"up", "w", "space"}, "release")

    self.name = "Player"
    self.inAir = false
end

function Player:update(dt)
    Player.super.update(self, dt)
    self.inAir = false
    
    if(self.speedY ~= 0) then
        self.inAir = true
    else
        self.inAir = false
    end
end

function Player:handleCollision(other, direction)
    Player.super.handleCollision(self, other, direction)
end

function Player:draw()
    Player.super.draw(self)
    
    self.debugInfo[#self.debugInfo + 1] = "In Air: " .. tostring(self.inAir)
    self.debugInfo[#self.debugInfo + 1] = "Collision with " .. (self.collidedWith and self.collidedWith.name or "None")
end

function Player:move(direction)
    local speed = self.properties.speed
    
    if direction == "left" and not self.collisions[3] then
        self.speedX = -speed
    elseif direction == "right" and not self.collisions[4] then
        self.speedX = speed
    elseif direction == "up" and not self.collisions[1] then
        self.speedY = -speed
    elseif direction == "down" and not self.collisions[2] then
        self.speedY = speed
    end
end

function Player:stop()
    self.speedX = 0
    self.speedY = 0
end

function Player:jump()
    if self.inAir then return end

    self.speedY = (self.properties.jumpForce * -1) or -300
end

return Player