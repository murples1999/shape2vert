--[ Created by Jeff Patterson
-- https://github.com/murples1999

-- This Program allows you to visually create polygon hitboxes for gameobjects in Love2D or any other software that 
-- requires a list of x, y vertices.

-- Simply run this using Love2D, click to select the vertices.
-- Press 'p' when done
-- The console will print a list of vertices you can copy/paste into your polygon shape.

-- You can Right Click to remove a point.
-- You can press 'c' to clear all.

-- Remember, Love2D has an unfortunate cap of 8 vertices.
-- I haven't put a cap in here, but you will get an error if you try to use more than 8 points in a polygon shape.

function love.load()
    -- Load the image you want to create a hitbox for
    image = love.graphics.newImage('Image.png')
    points = {}
    offsetX, offsetY = 0, 0 -- These will be used to store the offset to center the shape
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then -- Left mouse button adds points
        table.insert(points, x)
        table.insert(points, y)
    elseif button == 2 and #points > 0 then -- Right mouse button removes the last point
        table.remove(points)
        table.remove(points)
    end
end

function love.keypressed(key)
    -- Press 'p' to print the points in the console
    if key == 'p' then
        calculateOffset()
        print("Polygon Shape Points:")
        for i = 1, #points, 2 do
            local x = points[i] - offsetX
            local y = points[i + 1] - offsetY
            if i < #points then
                print(string.format("%f, %f,", x, y))
            else
                print(string.format("%f, %f", x, y)) -- No comma for the last point
            end
        end
    -- Press 'c' to clear all points
    elseif key == 'c' then
        points = {}
    end
end

function calculateOffset()
    local sumX, sumY = 0, 0
    for i = 1, #points, 2 do
        sumX = sumX + points[i]
        sumY = sumY + points[i + 1]
    end
    offsetX = sumX / (#points / 2)
    offsetY = sumY / (#points / 2)
end

function love.draw()
    love.graphics.draw(image, 0, 0, 0, 1, 1, offsetX, offsetY)

    -- Draw the points
    for i = 1, #points, 2 do
        love.graphics.circle('fill', points[i] - offsetX, points[i + 1] - offsetY, 5)
    end

    -- Optionally, draw lines connecting the points
    if #points >= 4 then -- Need at least two points to draw a line
        love.graphics.setColor(1, 0, 0) -- Set the color to red
        local drawPoints = {}
        for i = 1, #points, 2 do
            table.insert(drawPoints, points[i] - offsetX)
            table.insert(drawPoints, points[i + 1] - offsetY)
        end
        love.graphics.line(drawPoints)
        love.graphics.setColor(1, 1, 1) -- Reset the color to white
    end
end
