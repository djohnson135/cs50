WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200
push = require 'push'


function love.load()
    math.randomseed(os.time())

    love.graphics.setDefaultFilter('nearest', 'nearest')
    smallFont = love.graphics.newFont('04B_03__.ttf', 8)
    scoreFont = love.graphics.newFont('04B_03__.ttf', 32)
    -- love.graphics.setFont(smallFont)
    player1Score = 0
    player2Score = 0
    player1y = 30
    player2y = VIRTUAL_HEIGHT-40
    ballx = VIRTUAL_WIDTH/2-2
    bally = VIRTUAL_HEIGHT/2-2
    balldx = math.random(2) == 1 and -100 or 100
    balldy = math.random(-50, 50)
    gamestate = 'start'

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = false
    })
end 
function love.keypressed(key)
    if key == 'escape' then
            love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gamestate == 'start' then
            gamestate = 'play'
        elseif gamestate == 'play' then
            gamestate = 'start'
            ballx = VIRTUAL_WIDTH/2-2
            bally = VIRTUAL_HEIGHT/2-2
            balldx = math.random(2) == 1 and -100 or 100 --might replace with function
            balldy = math.random(-50, 50)
        end
    end
end
function love.update(dt)
    if love.keyboard.isDown('w') then
        player1y = math.max(0,player1y - PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then
        player1y = math.min(VIRTUAL_HEIGHT -20, player1y + PADDLE_SPEED * dt)
    end

    if love.keyboard.isDown('up') then
        player2y = math.max(0, player2y - PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down') then
        player2y = math.min(VIRTUAL_HEIGHT - 20, player2y + PADDLE_SPEED * dt)
    end

    if gamestate == 'play' then
        ballx = ballx + balldx * dt
        bally = bally + balldy * dt
    end

end
function love.draw()
    push:apply('start')
    love.graphics.clear(40/255,45/255, 52/255, 255 /255)
    love.graphics.setFont(smallFont)
    if gamestate == 'start' then
        love.graphics.printf("Hello Start State!", 0, 20, VIRTUAL_WIDTH, 'center') --[[this is a comment]]
    elseif gamestate == 'play' then
        love.graphics.printf("Hello Play State!", 0, 20, VIRTUAL_WIDTH, 'center')
    end
    love.graphics.setFont(scoreFont)
    love.graphics.print(player1Score, VIRTUAL_WIDTH/2 - 50,  VIRTUAL_HEIGHT / 3)
    
    love.graphics.print(player2Score, VIRTUAL_WIDTH/2 + 30,  VIRTUAL_HEIGHT / 3)

    love.graphics.rectangle('fill', ballx, bally,5, 5)--[[6,6 and -3 = even]]

    love.graphics.rectangle('fill', 10, player1y, 5, 20)

    love.graphics.rectangle('fill', VIRTUAL_WIDTH-10,player2y, 5, 20)
    
    push:apply('end')
end

-- function love.keyboard.isDown()