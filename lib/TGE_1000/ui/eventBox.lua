local Object = require "lib/TGE_1000/libraries/classic"
local windowU = require "lib/TGE_1000/utilities/window"
local format = require "lib/TGE_1000/utilities/format"
local InputManager = require "lib/TGE_1000/managers/inputManager"
local EventBox = Object:extend()

function EventBox:new(x, y, width, height, child, trigger)
    self.startX = x
    self.startY = y
    self.startWidth = width
    self.startHeight = height
    self.child = child
    self.trigger = trigger

    self.inputManager = InputManager()

    self.x, self.y = windowU.normalize(self.startX, self.startY)
    self.width, self.height = windowU.normalize(self.startWidth, self.startHeight)
end

function EventBox:update()
    if self:hasTriggered(self.trigger) then
        -- Handle the event
        -- remove event from queue
    end
end

function EventBox:hasTriggered(trigger)
    if trigger == "hover" then
        return self:isHover()
    elseif trigger == "press" then
        return self:isPressed()
    end
end

function EventBox:draw()
    self.child.draw()
end

function EventBox:isHover()
    return true 
end

function EventBox:isPressed()
    return true
end

return EventBox