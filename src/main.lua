-- main.lua
local Raycast = require("raycast")

-- Ray and lines setup
local ray
local lines = {
    { 100, 100, 200, 100 },
    { 200, 100, 200, 200 },
    { 100, 200, 200, 200 },
    { 100, 100, 100, 200 },
}

function love.load()
    -- Initialize ray origin and direction (e.g., towards the mouse)
    ray = Raycast.new(150, 150, 0, 0)
end

function love.update(dt)
    -- Update ray direction to point towards the mouse
    local mouseX, mouseY = love.mouse.getPosition()
    ray.dx = mouseX - ray.x
    ray.dy = mouseY - ray.y
end

function love.draw()
    -- Draw lines
    for _, line in ipairs(lines) do
        love.graphics.line(line[1], line[2], line[3], line[4])
    end

    -- Cast the ray and get the closest hit
    local hit = ray:castToLines(lines)
    if hit then
        -- Draw ray to the hit point
        love.graphics.setColor(1, 0, 0)
        love.graphics.line(ray.x, ray.y, hit.x, hit.y)
        love.graphics.circle("fill", hit.x, hit.y, 5)
    else
        -- Draw ray in direction of the mouse
        love.graphics.setColor(1, 1, 1)
        love.graphics.line(ray.x, ray.y, ray.x + ray.dx, ray.y + ray.dy)
    end
end
