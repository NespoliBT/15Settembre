local Object = require "lib/TGE_1000/libraries/classic"
local InputManager = Object:extend()

local boundKeysPressed = {}
local boundKeysReleased = {}
local boundKeysDown = {}

function InputManager:new()
    
end


function InputManager:bindKey(action, keys, eventType)
    if type(keys) == "string" then
        keys = {keys}
    end

    for _, key in ipairs(keys) do
        if eventType == "press" then
            if not boundKeysPressed[key] then
                boundKeysPressed[key] = {}
            end
            boundKeysPressed[key][action] = action
        elseif eventType == "release" then
            if not boundKeysReleased[key] then
                boundKeysReleased[key] = {}
            end
            boundKeysReleased[key][action] = action
        elseif eventType == "keep" then
            if not boundKeysDown[key] then
                boundKeysDown[key] = {isDown = false}
            end
            boundKeysDown[key][action] = action
        else
            error("Invalid event type: " .. tostring(eventType) .. ". Use 'press' or 'release'.")
        end
    end
end

function InputManager:keypressed(key)
    if boundKeysPressed[key] then
        for action, func in pairs(boundKeysPressed[key]) do
            if action ~= "eventType" and type(func) == "function" then
                func()
            end
        end
    end
end

function InputManager:keyreleased(key)
    if boundKeysReleased[key] then
        for action, func in pairs(boundKeysReleased[key]) do
            if action ~= "eventType" and type(func) == "function" then
                func()
            end
        end
    end
end

function InputManager:updateDownKeys() 
    for key in pairs(boundKeysDown) do
        local isDown = love.keyboard.isDown(key)

        if isDown then
            for action, func in pairs(boundKeysDown[key]) do
                if action ~= "isDown" and type(func) == "function" then
                    func()
                end
            end
        end
    end
end

return InputManager 
