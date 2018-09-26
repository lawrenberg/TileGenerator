require "Logger"
require "Tile"
require "Generators.WallGenerator"
require "CellType"
require "Cell"

describe("Test Building Bottom Wall on 300x300 tile", function()
    local tile = Tile:create(300, 300, 15)
    local wall = Cell:create(CellType.WALL)
    local startingColumn, endingColumn, startingRow, endingRow = WallGenerator:calculateWallPoint(tile, cell, "bottom")
    WallGenerator:buildSide(tile, wall, "bottom", startingColumn, endingColumn, startingRow, endingRow)
    it("Testing calculated points", function()
        assert.is_equal(0, startingColumn)
        assert.is_equal(tile:getCellWidthLength(), endingColumn)
        assert.is_equal(tile:getCellHeightLength() - 10, startingRow)
        assert.is_equal(tile:getCellHeightLength(), endingRow)
    end)
end);