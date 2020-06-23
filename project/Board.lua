require 'Util'
require 'Piece'
Board = Class{}

local piece = {
    WhiteKing = 1,
    WhiteQueen = 2,
    WhiteBishop = 3,
    WhiteKnight = 4,
    WhiteRook = 5,
    WhitePawn = 6,
    BlackKing = 7,
    BlackQueen = 8,
    BlackBishop = 9,
    BlackKnight = 10,
    BlackRook = 11,
    BlackPawn = 12,
}

local gridSize, offsetX, offsetY, squareSize = 480,160,60,60
local scaleFactor = 0.18

function Board:init()
    self.spritesheet = love.graphics.newImage('assets/spritesheet.png')
    self.sprites = generateQuads(self.spritesheet, 333.3, 333.5)
    self.tileWidth = 333.3
    self.tileHeight = 333.5
    self.mapWidth = 8
    self.mapHeight = 8
    self.tiles = {}
    self.mapWidthPixels = self.mapWidth * self.tileWidth
    self.mapHeightPixels = self.mapHeight * self.tileHeight
    self.grid = {}
    initialGrid = {
        ["A8"] = piece.BlackRook,
        ["B8"] = piece.BlackKnight,
        ["C8"] = piece.BlackBishop,
        ["D8"]= piece.BlackQueen,
        ["E8"]= piece.BlackKing,
        ["F8"]= piece.BlackBishop,
        ["G8"]= piece.BlackKnight,
        ["H8"]= piece.BlackRook,
        ["A7"]= piece.BlackPawn,
        ["B7"]= piece.BlackPawn,
        ["C7"]= piece.BlackPawn,
        ["D7"]= piece.BlackPawn,
        ["E7"]= piece.BlackPawn,
        ["F7"]= piece.BlackPawn,
        ["G7"]= piece.BlackPawn,
        ["H7"]= piece.BlackPawn,
        ["A1"]= piece.WhiteRook,
        ["B1"]= piece.WhiteKnight,
        ["C1"]= piece.WhiteBishop,
        ["D1"]= piece.WhiteQueen,
        ["E1"]= piece.WhiteKing,
        ["F1"]= piece.WhiteBishop,
        ["G1"]= piece.WhiteKnight,
        ["H1"]= piece.WhiteRook,
        ["A2"]= piece.WhitePawn,
        ["B2"]= piece.WhitePawn,
        ["C2"]= piece.WhitePawn,
        ["D2"]= piece.WhitePawn,
        ["E2"]= piece.WhitePawn,
        ["F2"]= piece.WhitePawn,
        ["G2"]= piece.WhitePawn,
        ["H2"]= piece.WhitePawn
    }
    for y = 1,8 do
        self.grid[y] = {}
        for x = 1,8 do
            self.grid[y][x] = 0
        end
    end
    for k, pie in pairs(initialGrid) do
        local x,y = Board.toXY(k)
        self:placePiece(pie, x,y)
    end
end

    -- function boardMethods:debugPrint()
    --     for i, row  in ipairs(self.grid) do
    --     print(inspect(self.grid[i]))
    -- end


    -- for y = 1, self.mapHeight do
    --     for x = 1, self.mapWidth do
            
    --         -- support for multiple sheets per tile; storing tiles as tables 
    --         self:setTile(x, y, WKING)
    --     end
    -- end

function Board.toXY(algN)
    assert(type(algN) == "string", "toXY expects a string of 2 characters. e.g. A8")
    if algN:len() ~= 2 then
        error("Invalid algebraic chess notation: "..algN)
    end
    local letter = algN:byte(1)
    local x = 0
    if letter >= 65 and letter <= 72 then
        x = letter - 64
    elseif letter >= 97 and letter <= 104 then
        x = letter - 96
    else
        error("Invalid algebraic chess notationl: "..algN)
    end
    
    local y = 0
    local num = tonumber(algN:sub(2))
    if num < 1 or num > 8 then
        error("Invalid algebraic chess notationn: "..algN)
    else
        y = 9 - num
    end
    
    -- debug TO REMOVE
    if x == 0 or y == 0 then
        error("Internal error, non-exhaustive matching")
    end
    return x,y
end



function Board:placePiece(pie, x, y)
    if not Piece.isPiece(pie) then
        error("Invalid argument to placePiece: "..pie)
    end
    self.grid[y][x] = pie
end

function Board:render()
    for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do
            local tile = self:getTile(x, y)
            if tile ~= TILE_EMPTY then
                love.graphics.draw(self.spritesheet, self.sprites[tile],
                    (x - 1) * self.tileWidth, (y - 1) * self.tileHeight)
            end
        end
    end
end


function Board:getTile(x, y)
    return self.tiles[(y - 1) * self.mapWidth + x]
end

function Board:setTile(x, y, id)
    self.tiles[(y - 1) * self.mapWidth + x] = id
end

function Board:tileAt(x, y)
    return {
        x = math.floor(x / self.tileWidth) + 1,
        y = math.floor(y / self.tileHeight) + 1,
        id = self:getTile(math.floor(x / self.tileWidth) + 1, math.floor(y / self.tileHeight) + 1)
    }
end

-- local Board = {__index = boardMethods}

-- function Board.new(sheet, windowWidth, windowHeight)
--     local b =  setmetatable({
--         -- spriteSheet = sheet,
--         windowHeight = windowHeight,
--         windowWidth = windowWidth,
--         grid = {}
--                             }, Board)
--     b:init()
--     -- b:calculateBoardSizes()
--     return b
-- end


function Board:draw()
    love.graphics.clear()
    love.graphics.setColor(255, 255, 255)
    -- draw grid
    love.graphics.line(offsetX,offsetY, offsetX + gridSize,offsetY)
    love.graphics.line(offsetX,offsetY, offsetX,offsetY + gridSize)
    love.graphics.line(offsetX + gridSize,offsetY, offsetX + gridSize,offsetY + gridSize)
    love.graphics.line(offsetX,offsetY + gridSize, offsetX + gridSize,offsetY + gridSize)

    for i = offsetX,offsetX+gridSize,squareSize do
        love.graphics.line(i,offsetY, i,offsetY+gridSize)
    end
    for i = offsetY,offsetY+gridSize,squareSize do
        love.graphics.line(offsetX,i, offsetX+gridSize,i)
    end

    local i = 1
    local j = 1
    for y = offsetY, offsetY+gridSize-squareSize, squareSize do
        for x = offsetX, offsetX+gridSize-squareSize, squareSize do

        if (i % 2 == 0 and j % 2 ~= 0) or (i % 2 ~= 0 and j % 2 == 0) then
            love.graphics.setColor(255, 255, 255,255)
            love.graphics.rectangle('fill', x, y, squareSize, squareSize)
        else
            love.graphics.setColor(60, 60, 60)
            love.graphics.rectangle('fill', x, y, squareSize, squareSize)
        end
        i = i + 1
        end
        j = j + 1
    end

    -- Draw pieces
    for y = 1,8 do
        for x = 1,8 do
        if self.grid[y][x] ~= 0 then
            local xP, yP = Board:gridToPixels(x, y)
            love.graphics.setColor(255, 0, 0)   
            love.graphics.print(self.grid[y][x], xP, yP)
            love.graphics.setColor(255, 255, 255)
            -- love.graphics.draw(self.image ,quad ,x,y ,0, scaleFactor,scaleFactor)
            love.graphics.draw(self.spritesheet, self.sprites[self.grid[y][x]],xP,yP,0, scaleFactor, scaleFactor)

            -- self.spritesheet:draw(self.grid[y][x], xP, yP, scaleFactor)
            end
        end
    end
end

-- local Board = {__index = boardMethods}

function Board:gridToPixels(x,y)
    local xPixel = (offsetX - squareSize) + (x * squareSize)
    local yPixel = (offsetY - squareSize) + (y * squareSize)
    return xPixel, yPixel
end

