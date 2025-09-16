local Object = require "lib/TGE_1000/libraries/classic"
local InputManager = Object:extend()

local boundKeysPressed = {}
local boundKeysReleased = {}

function InputManager:new()
    
end


function InputManager:bindKey(action, keys, eventType)
    if type(keys) == "string" then
        keys = {keys}
    end

    for _, key in ipairs(keys) do
        if eventType == "press" then
            if not boundKeysPressed[key] then
                boundKeysPressed[key] = {eventType = "press"}
            end
            boundKeysPressed[key][action] = action
        elseif eventType == "release" then
            if not boundKeysReleased[key] then
                boundKeysReleased[key] = {eventType = "release"}
            end
            boundKeysReleased[key][action] = action
        else
            error("Invalid event type: " .. tostring(eventType) .. ". Use 'press' or 'release'.")
        end
    end
end

function InputManager:keypressed(key)
    if boundKeysPressed[key] and boundKeysPressed[key].eventType == "press" then
        for action, func in pairs(boundKeysPressed[key]) do
            if action ~= "eventType" and type(func) == "function" then
                func()
            end
        end
    end
end

function InputManager:keyreleased(key)
    if boundKeysReleased[key] and boundKeysReleased[key].eventType == "release" then
        for action, func in pairs(boundKeysReleased[key]) do
            if action ~= "eventType" and type(func) == "function" then
                func()
            end
        end
    end
end

return InputManager 
