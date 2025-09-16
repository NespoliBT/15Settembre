local format = {}

function format.formatValue(value)
    if value >= 1e9 then
        return string.format("%.1fB", value / 1e9)
    elseif value >= 1e6 then
        return string.format("%.1fM", value / 1e6)
    elseif value >= 1e3 then
        return string.format("%.1fK", value / 1e3)
    else
        return tostring(
            math.floor(value)
        )
    end
end

function format.splitText(text, maxWidth, font)
    local lines = {}
    for paragraph in text:gmatch("([^\n]*)\n?") do
        if paragraph == "" and #lines > 0 then
            table.insert(lines, "")
        elseif paragraph ~= "" then
            local words = {}
            for word in paragraph:gmatch("%S+") do
                table.insert(words, word)
            end

            local currentLine = ""
            for i, word in ipairs(words) do
                local testLine = currentLine .. (currentLine == "" and "" or " ") .. word
                local testWidth = font:getWidth(testLine)
                if testWidth <= maxWidth then
                    currentLine = testLine
                else
                    if currentLine ~= "" then
                        table.insert(lines, currentLine)
                    end
                    currentLine = word
                end
            end

            currentLine = currentLine:gsub("\\n", "")

            if currentLine ~= "" then
                table.insert(lines, currentLine)
            end
        end
    end
    return lines
end

function format.hexToRGBA(hex)
    hex = hex:gsub("#", "")
    r = tonumber("0x" .. hex:sub(1, 2)) / 255
    g = tonumber("0x" .. hex:sub(3, 4)) / 255
    b = tonumber("0x" .. hex:sub(5, 6)) / 255
    a = 1

    if #hex == 8 then
        a = tonumber("0x" .. hex:sub(7, 8)) / 255
    end

    return {
        r,
        g,
        b,
        a
    }
end

function format.stringToColor(str)
    -- make a function that given a string it converts it to a hex color in lua
    local hash = 0
    for i = 1, #str do
        hash = hash + string.byte(str, i) * (i * #str * 23)
    end
    
    return string.format("#%06X", hash)
end

return format