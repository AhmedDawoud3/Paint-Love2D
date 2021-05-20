math.randomseed(os.time())

r, g, b, a = math.random(), math.random(), math.random(), 1
rd = 10
function love.load()
    love.window.setTitle("Paint")
    love.window.setMode(1280, 720)
    love.mouse.setVisible(false)
    buffers = {}
    -- true and false for easier switching, see below
    buffers[true] = love.graphics.newCanvas()
    buffers[false] = love.graphics.newCanvas()
    buffers.current = true
end
function love.update()
    dt = 1 / 100000000000
end
function love.draw()
    if love.mouse.isDown(1) then
        love.graphics.setCanvas(buffers[buffers.current]) -- draw to current buffer
        love.graphics.setColor(255, 255, 255, 100) -- alpha value to fade the previous frame out
        love.graphics.draw(buffers[not buffers.current], 0, 0) -- draw previous frame

        love.graphics.setColor(r, g, b, a)
        -- draw new content over last frame
        love.graphics.circle('fill', love.mouse.getX(), love.mouse.getY(), rd)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setCanvas() -- draw to screen again
        love.graphics.draw(buffers[buffers.current], 0, 0) -- draw 'ghosted' scene
        buffers.current = not buffers.current -- switch buffers
       
    else
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setCanvas() -- draw to screen again
        love.graphics.draw(buffers[buffers.current], 0, 0) -- draw 'ghosted' scene
        buffers.current = not buffers.current -- switch buffers
        
        love.graphics.setColor(r, g, b, a)
        -- draw new content over last frame
        love.graphics.circle('fill', love.mouse.getX(), love.mouse.getY(), rd)
    end
    love.graphics.setColor(r, g, b, a)
    love.graphics.rectangle('fill', 0, 0, 100, 100)
end
function love.keypressed(k)
    if k == 'r' then
        buffers[true] = love.graphics.newCanvas()
        buffers[false] = love.graphics.newCanvas()
    end
end

function love.mousepressed(x, y, button)
    if button == 2 then
        r = math.random()
        g = math.random()
        b = math.random()
    end
end
function love.wheelmoved(x, dy)
    if dy > 0 then
        rd = rd + 10
    elseif dy < 0 then
        rd = rd - 10
    end
end
