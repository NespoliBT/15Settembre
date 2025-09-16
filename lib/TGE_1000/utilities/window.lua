local config = require "lib/TGE_1000/data/config"

local windowU = {}

function windowU.configureWindow(windowData)
    local title = windowData.title or config.window.title
    local width = windowData.width or config.window.width
    local height = windowData.height or config.window.height
    local fullscreen = windowData.fullscreen or config.window.fullscreen
    local resizable = windowData.resizable or config.window.resizable
    local vsync = windowData.vsync or config.window.vsync

    love.window.setTitle(title)
    love.window.setMode(width, height, {
        fullscreen = fullscreen,
        resizable = resizable,
        vsync = vsync
    })
end

function windowU.normalize(x, y)
    local aspectRatio = config.window.width / config.window.height
    local windowWidth = love.graphics.getWidth()
    local windowHeight = love.graphics.getHeight()
    local windowAspectRatio = windowWidth / windowHeight

    local scaleX, scaleY
    if windowAspectRatio > aspectRatio then
        scaleY = windowHeight / config.window.height
        scaleX = scaleY
    else
        scaleX = windowWidth / config.window.width
        scaleY = scaleX
    end

    return x * scaleX, y * scaleY
end

return windowU