require "boot.starter"
require "Tile"
require "Generators.WallGenerator"
require "CellType"
require "Cell"

describe("Test Building Bottom Wall on 300x300 tile", function()
    local tile = Tile:create(300, 300, 15)
    local wall = Cell:create(CellType.WALL)
    local startingColumn, endingColumn, startingRow, endingRow = WallGenerator:calculateWallPoint(tile, cell, "bottom")
    WallGenerator:buildSide(tile, wall, "bottom", startingColumn, endingColumn, startingRow, endingRow)
    it("Testing starting Column", function() 
        assert.is_equal(1, startingColumn)
    end)

    it("Testing ending column", function() 
        assert.is_equal(tile:getCellWidthLength(), endingColumn)
    end)
    it("Testing starting row", function() 
        -- the minus 11 is so that the 10th row isn't included
        assert.is_equal(tile:getCellHeightLength() - 9, startingRow)
    end)
    it("Testing ending row", function() 
        assert.is_equal(tile:getCellHeightLength(), endingRow)
    end)
end)

describe("Test Building Right and Bottom Wall on 300x400 tile", function()
    local tile = Tile:create(300, 400, 15)
    local wall = Cell:create(CellType.WALL)
    --Build Bottom
    local startingColumn, endingColumn, startingRow, endingRow = WallGenerator:calculateWallPoint(tile, cell, "bottom")
    WallGenerator:buildSide(tile, wall, "bottom", startingColumn, endingColumn, startingRow, endingRow)
    --Build Right
    local rightStartingColumn, rightEndingColumn, rightStartingRow, rightEndingRow = WallGenerator:calculateWallPoint(tile, cell, "right")
    WallGenerator:buildSide(tile, wall, "right", rightStartingColumn, rightEndingColumn, rightStartingRow, rightEndingRow)
    
    it("Testing Bottom starting Column", function() 
        assert.is_equal(1, startingColumn)
    end)

    it("Testing Bottom ending column", function() 
        assert.is_equal(tile:getCellWidthLength(), endingColumn)
    end)
    it("Testing Bottom starting row", function() 
        -- the minus 11 is so that the 10th row isn't included
        assert.is_equal(tile:getCellHeightLength() - 9, startingRow)
    end)
    it("Testing Bottom ending row", function() 
        assert.is_equal(tile:getCellHeightLength(), endingRow)
    end)
  
    it("Testing Right starting Column", function() 
        assert.is_equal(tile:getCellWidthLength() -  9, rightStartingColumn)
    end)

    it("Testing Right ending column", function() 
        assert.is_equal(tile:getCellWidthLength(), rightEndingColumn)
    end)
    it("Testing Right starting row", function() 
        -- the minus 11 is so that the 10th row isn't included
        assert.is_equal(1, rightStartingRow)
    end)
    it("Testing Right ending row", function() 
        assert.is_equal(tile:getCellHeightLength(), rightEndingRow)
    end)
  
end);