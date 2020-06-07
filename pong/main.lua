WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false; --[[windowed]]
        vsync = true; --[[refresh rate matches moniter no skipping frames]]
        resizable = false; --[[aspect ratio not changeable]]
    })
end 

function love.draw()
    love.graphics.printf("Hello Pong!", 0, WINDOW_HEIGHT / 2 - 6, WINDOW_WIDTH, 'center') --[[this is a comment]]
end

