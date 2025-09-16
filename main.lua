local windowU = require "lib/TGE_1000/utilities/window"
local EntityManager = require "lib/TGE_1000/managers/entityManager"
local InputManager = require "lib/TGE_1000/managers/inputManager"

local windowData = require "data/window"
local world = require "data/world"

local Platform = require "src/entities/platform"
local Player = require "src/entities/player"

local entityManager;
local inputManager;

function love.load()
    windowU.configureWindow(windowData)
    entityManager = EntityManager()
    inputManager = InputManager()


    entityManager:addEntity(Platform(100, 300, 200, 20))
    entityManager:addEntity(Platform(200, 300, 200, 20))
    entityManager:addEntity(Platform(300, 500, 200, 20))

    entityManager:addEntity(Player(150, 0, 30, 50))
end

function love.keypressed(key)
    inputManager:keypressed(key)
end

function love.keyreleased(key)
    inputManager:keyreleased(key)
end

function love.update(dt)
    entityManager:update(dt)
end

function love.draw()
    entityManager:draw()
end
