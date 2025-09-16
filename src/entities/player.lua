local SolidEntity = require "lib/TGE_1000/entities/solidEntity"
local world = require "data/world"
local Player = SolidEntity:extend()
local InputManager = require "lib/TGE_1000/managers/inputManager"

local inputManager = InputManager()

function Player:new(x, y, width, height)
    local properties = {
        gravity = world.gravity,
        speed = 200,
        jumpForce = -400
    }

    Player.super.new(self, x, y, width, height, properties)

    inputManager:bindKey(function() self:stop() end, {"left", "a"}, "release")
    inputManager:bindKey(function() self:stop() end, {"right", "d"}, "release")

    inputManager:bindKey(function() self:move("left") end, {"left", "a"}, "press")
    inputManager:bindKey(function() self:move("right") end, {"right", "d"}, "press")

    inputManager:bindKey(function() self:jump() end, {"up", "w", "space"}, "press")

    self.name = "Player"
end

function Player:update(dt)
    Player.super.update(self, dt)
end

function Player:draw()
    Player.super.draw(self)
end

function Player:move(direction)
    local speed = self.properties.speed

    if direction == "left" then
        self.speedX = -speed
    elseif direction == "right" then
        self.speedX = speed
    end
end

function Player:stop()
    self.speedX = 0
end

function Player:jump()
    self.speedY = self.properties.jumpForce or -300
end

return Player