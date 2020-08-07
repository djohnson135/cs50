
Class = require 'class'
push = require 'push'
require 'Board'

-- local selectedX, selectedY = -1,-1

--need to add board {{{{COMPLETED}}}}
--need to add peice movement {{{{COMPLETED}}}}
--need to add game states 
--need to add peice class  
--need to add win condition
math.randomseed(os.time())
BOARD = Board()
function love.load()
    
    -- sheet = sprites.new(spriteSheet)
    width, height = love.graphics.getDimensions()
    love.keyboard.keysPressed = {}
    -- chessboard = Board.new(width, height)
    -- chessboard:debugPrint()
    gameState = 'White'
    dragging = { active = false, diffX = 0, diffY = 0 }

end

function love.draw()
    -- chessboard:draw()
    -- push:apply('start')
    -- love.graphics.clear()
    BOARD:draw()
    love.graphics.setColor(255, 255, 255)
    
    
    -- push:apply('end')
end
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end
function love.update(dt)
    if dragging.active then
        image.x = love.mouse.getX() - dragging.diffX
        image.y = love.mouse.getY() - dragging.diffY
    end
    love.keyboard.keysPressed = {}
end

function love.mousepressed(x, y, button)
    if button == 1 then
        --print("pressed: "..x..", "..y)
        xG, yG = BOARD:pixelsToGrid(x,y)
        if (xG == 0 and yG == 0) then
            return
        end
        --add piece functions

        
        if BOARD:returnselectedX() == -1 or BOARD:returnselectedY() == -1 then
            --print("select")
            BOARD:setselectedX(xG)
            BOARD:setselectedY(yG)
        elseif BOARD:returnselectedX() ~= xG or BOARD:returnselectedY() ~= yG then --and BOARD:check() 
            gridPiece = BOARD:returnPiece(BOARD:returnselectedY(),BOARD:returnselectedX())
            if gridPiece ~= 0 then
                if BOARD:check(gridPiece, xG, yG) then
                    BOARD:movePiece(BOARD:returnselectedX(), BOARD:returnselectedY(), xG,yG)
                end
            end
            BOARD:setselectedX(-1)
            BOARD:setselectedY(-1)
        elseif BOARD:returnselectedX() == xG and BOARD:returnselectedY() == yG then
            BOARD:setselectedX(-1)
            BOARD:setselectedY(-1)
        end
    end
    
end

function love.resize(w, h)
    push:resize(w, h)
end
