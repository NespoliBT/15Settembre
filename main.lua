local windowU = require "lib/TGE_1000/utilities/window"
local format = require "lib/TGE_1000/utilities/format"

local EntityManager = require "lib/TGE_1000/managers/entityManager"
local InputManager = require "lib/TGE_1000/managers/inputManager"
local UIManager = require "lib/TGE_1000/managers/UIManager"
local LayeringManager = require "lib/TGE_1000/managers/layeringManager"

local Button = require "lib/TGE_1000/ui/button"
local Label = require "lib/TGE_1000/ui/label"


local windowData = require "data/window"
local world = require "data/world"

local Platform = require "src/entities/platform"
local CubeSpawner = require "src/entities/cubeSpawner"
local Player = require "src/entities/player"
local Background = require "src/entities/background"

local entityManager
local inputManager
local uiManager
local layeringManager

function love.load()
    windowU.configureWindow(windowData)

    entityManager = EntityManager()
    inputManager = InputManager()
    uiManager = UIManager()
    layeringManager = LayeringManager()

    layeringManager:addLayer(1, "background")
    layeringManager:addLayer(2, "midground")
    layeringManager:addLayer(3, "foreground")
    layeringManager:addLayer(4, "UI")

    local button = Button(10, 10, 20, 10, Label(10, 10, 20, 10, "click me!"), function() print("nice!") end)

    local ground = Platform(0, 100, 192, 10, {
        color = format.hexToRGBA("#8967B3"),
        layer = "midground"
    })
    local leftWall = Platform(-10, 0, 10, 108, {
        color = format.hexToRGBA("#8967B3"),
        layer = "midground"
    })
    local rightWall = Platform(192, 0, 10, 108, {
        color = format.hexToRGBA("#8967B3"),
        layer = "midground"
    })

    entityManager:addEntity(Background(0, 0, 192, 108, {
        color = format.hexToRGBA("#624E88"),
        layer = "background"
    }))

    entityManager:addEntity(ground)
    entityManager:addEntity(leftWall)
    entityManager:addEntity(rightWall)

    entityManager:addEntity(Player(50, 50, 10, 10, {
        gravity = world.gravity,
        speed = 50,
        jumpForce = 250,
        color = format.hexToRGBA("#E6D9A2"),
        layer = "midground"
    }))
    entityManager:addEntity(CubeSpawner(130, 50, 5, 5,
    {
        spawnInterval = 0.2,
        maxSpawns = 50,
        spawnRange = 30,
        color = format.hexToRGBA("#00000000"),
        layer = "midground",
        entityProps = {
            gravity = world.gravity,
            color = format.hexToRGBA("#CB80AB"),
        }
    }))

    uiManager:addElement(button)
end

function love.keypressed(key)
    inputManager:keypressed(key)
end

function love.keyreleased(key)
    inputManager:keyreleased(key)
end

function love.update(dt)
    entityManager:update(dt)
    inputManager:updateDownKeys()
    uiManager:update()
end

function love.draw()
    entityManager:draw()
end
