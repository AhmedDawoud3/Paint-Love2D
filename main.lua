math.randomseed(os.time())
crtl = false
alt = false
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
    currentMode = 0
end
function love.update()
    if love.keyboard.isDown('lctrl') or love.keyboard.isDown('rctrl') then
        crtl = true
    else
        crtl = false
    end
    if love.keyboard.isDown('ralt') or love.keyboard.isDown('lalt') then
        alt = true
    else
        alt = false
    end
end
function love.draw()
    if love.mouse.isDown(1) then
        love.graphics.setCanvas(buffers[buffers.current]) -- draw to current buffer
        love.graphics.setColor(255, 255, 255, 100) -- alpha value to fade the previous frame out
        love.graphics.draw(buffers[not buffers.current], 0, 0) -- draw previous frame

        love.graphics.setColor(r, g, b, a)
        -- draw new content over last frame
        if currentMode == 0 then
            love.graphics.circle('fill', love.mouse.getX(), love.mouse.getY(), rd)
        elseif currentMode == 1 then
            love.graphics.rectangle('fill', love.mouse.getX() - rd / 2, love.mouse.getY() - rd / 2, rd, rd)
        end
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
        if currentMode == 0 then
            love.graphics.circle('fill', love.mouse.getX(), love.mouse.getY(), rd)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.circle('line', love.mouse.getX(), love.mouse.getY(), rd)
        elseif currentMode == 1 then
            love.graphics.rectangle('fill', love.mouse.getX() - rd / 2, love.mouse.getY() - rd / 2, rd, rd)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.rectangle('line', love.mouse.getX() - rd / 2, love.mouse.getY() - rd / 2, rd, rd)
        end
    end
    love.graphics.setColor(r, g, b, a)
    love.graphics.rectangle('fill', 0, 0, 100, 100)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setLineWidth(5)
    love.graphics.rectangle('line', 0, 0, 100, 100)
    love.graphics.setLineWidth(1)
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
    if crtl then
        if dy > 0 then
            rd = rd + 10
        elseif dy < 0 then
            rd = rd - 10
        end
    else
        if alt then
            if dy > 0 or dy < 0 then
                if currentMode == 0 then
                    currentMode = 1
                else
                    currentMode = 0
                end
            end
        end
    end
end
