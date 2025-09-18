local fonts = require "lib/TGE_1000/data/fonts"
local Object = require "lib/TGE_1000/libraries/classic"
local format = require "lib/TGE_1000/utilities/format"

local Text = Object:extend()

function Text:new(x, y, str, font, align, limit, color)
    self.startX = x
    self.startY = y
    self.str = str
    self.font = font or fonts.regular
    self.align = align or "tl"
    self.limit = limit or love.graphics.getWidth()
    self.color = color or {1, 1, 1}
    self.lines = {}
    self.linesCoordinates = {}

    self.lines = format.splitText(self.str, self.limit, self.font)
    self.linesInstances = {}

    for i, line in ipairs(self.lines) do
        self.linesInstances[i] = love.graphics.newText(self.font, line)
        local x, y = self:applyAlignment(line, self.startX, self.startY + (i - 1) * self.font:getHeight())
        self.linesCoordinates[i] = {x = x, y = y}
    end
end

function Text:update(dt)
    self.lines = {}
    self.linesCoordinates = {}
    self.linesInstances = {}

    if(self.str) then
        self.lines = format.splitText(self.str, self.limit, self.font)

        for i, line in ipairs(self.lines) do
            local x, y = self:applyAlignment(line, self.startX, self.startY + (i - 1) * self.font:getHeight())
            self.linesCoordinates[i] = {x = x, y = y}
            
            self.linesInstances[i] = love.graphics.newText(self.font, line)
        end
    end
end

function Text:delete()
    for i, line in ipairs(self.linesInstances) do
        line:release()
    end
    self.lines = {}
    self.linesCoordinates = {}
    self.linesInstances = {}
end

function Text:draw()
    if(self.linesInstances) then
        for i, line in ipairs(self.linesInstances) do
            love.graphics.setColor(self.color)
            love.graphics.draw(line, self.linesCoordinates[i].x, self.linesCoordinates[i].y)
            love.graphics.setColor(1, 1, 1)
        end
    end
end

function Text:applyAlignment(line, x, y)
    local width = self.font:getWidth(line)
    local height = self.font:getHeight()

    -- not sure this works probably not
    if (self.align == "tc") then
        x = x + (self.limit - width) / 2 
        y = y
    elseif (self.align == "bc") then
        x = x + (self.limit - width) / 2 
        y = love.graphics.getHeight() - height + y
    elseif (self.align == "cc") then
        x = x + (self.limit - width) / 2
        y = love.graphics.getHeight() / 2 - height / 2 + y
    elseif (self.align == "tr") then
        x = x + (self.limit - width)
        y = y
    elseif (self.align == "br") then
        x = x+ (self.limit - width)
        y = love.graphics.getHeight() - height + y
    elseif (self.align == "tl") then
        x = x
        y = y
    elseif (self.align == "bl") then
        x = x
        y = love.graphics.getHeight() - height + y
    end

    return x, y
end

return Text