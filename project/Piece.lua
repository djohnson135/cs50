Piece = Class{}

local piece = {
    WhiteKing = 1,
    WhiteQueen = 2,
    WhiteRook = 3,
    WhiteBishop = 4,
    WhiteKnight = 5,
    WhitePawn = 6,
    BlackKing = 7,
    BlackQueen = 8,
    BlackRook = 9,
    BlackBishop = 10,
    BlackKnight = 11,
    BlackPawn = 12,
}

function Piece.isPiece(x)
    return (x >= 1 and x <=12)
end



function Piece:Return(pieceval)
    
    if self.pieceval == piece.WhiteKing then
        return "KING"
    end
    
end

function Piece:check(pieceval, posx, posy)

end

function Piece:rook(posx, posy)
end

function Piece:queen(posx, posy)
end

function Piece:pawn(posx, posy)
end

function Piece:knight(posx, posy)
end

function Piece:bishop(posx, posy)
end

function Piece:king()
end