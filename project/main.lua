
Class = require 'class'
push = require 'push'
require 'Board'

local selectedX, selectedY = 0,0

BOARD = Board()
function love.load()
    
    -- sheet = sprites.new(spriteSheet)
    width, height = love.graphics.getDimensions()
    -- chessboard = Board.new(width, height)
    -- chessboard:debugPrint()
end

function love.draw()
    -- chessboard:draw()
    -- push:apply('start')
    -- love.graphics.clear()
    BOARD:draw()
    love.graphics.setColor(255, 255, 255)
    
    -- push:apply('end')
end

function love.update(dt)
end



function love.resize(w, h)
    push:resize(w, h)
end