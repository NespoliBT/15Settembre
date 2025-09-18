local Object = require "lib/TGE_1000/libraries/classic"
local UIManager = Object:extend()

local elements = {}

function UIManager:new()

end

function UIManager:addElement(element)
    table.insert(elements, element)
end

function UIManager:update(dt)
    for _, element in ipairs(elements) do
        element:update(dt)
    end
end

-- gotta do dis in layers somehow
function UIManager:draw()
    for _, element in ipairs(elements) do
        element:draw()
    end
end

function UIManager:getElements()
    return elements
end

return UIManager
