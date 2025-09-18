local Object = require "lib/TGE_1000/libraries/classic"
local config = require "lib/TGE_1000/data/config"
local format = require "lib/TGE_1000/utilities/format"
local windowU = require "lib/TGE_1000/utilities/window"
local Entity = Object:extend()

function Entity:new(x, y, width, height, properties)
    self.name = "Entity"
    self.startX = x or 0
    self.startY = y or 0
    self.startWidth = width or 50
    self.startHeight = height or 50
    self.isDestroyed = false

    self.debugInfo = {}

    self.x, self.y = windowU.normalize(self.startX, self.startY)
    self.width, self.height = windowU.normalize(self.startWidth, self.startHeight)
    self.properties = properties or {}
    self.color = self.properties.color or format.hexToRGBA(format.stringToColor(self.name))
end

function Entity:update(dt)
    -- TODO only trigger this on window resize
    self.x, self.y = windowU.normalize(self.startX, self.startY)
    self.width, self.height = windowU.normalize(self.startWidth, self.startHeight)
end

function Entity:draw()
    self.color = self.properties.color or format.hexToRGBA(format.stringToColor(self.name))
    if config.debug.simulation then
        love.graphics.setColor(self.color)
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
        love.graphics.setColor(1, 1, 1, 1)

        if config.debug.info then
            for i, info in ipairs(self.debugInfo) do
                love.graphics.print(info, self.x, self.y + (i + 2) * -15)
            end
        end
        self.debugInfo = {}
    end

    if config.debug.entityName == self.name then
        love.graphics.setColor(self.color)
        love.graphics.print(self.name .. " (" .. self.x .. ", " .. self.y .. ")", self.x, self.y - 20)
        love.graphics.setColor(1, 1, 1)
    end

    if not config.debug.simulation then
        print("drawing...")
    end
end

return Entity