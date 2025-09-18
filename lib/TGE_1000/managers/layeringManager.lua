local Object = require "lib/TGE_1000/libraries/classic"
local LayeringManager = Object:extend()

local layers = {}

function LayeringManager:new()
    print("Layersssssss.....")
end

function LayeringManager:addLayer(level, name)
    if not layers[level] then
        layers[level] = {}
    end

    layers[level].name = name
end

function LayeringManager:getLayerName(level)
    return layers[level] and layers[level].name or nil
end

function LayeringManager:addToLayer(level, element)
    if not layers[level] then
        print("Layer " .. tostring(level) .. " does not exist. Cannot add element.")
        return
    end

    table.insert(layers[level], element)
end

return LayeringManager