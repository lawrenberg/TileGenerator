require 'util.TableUtil'
require 'CellType'
require 'Cell'
require 'Generators.WallGenerator'
require 'Generators.ColumnGenerator'

PathGenerator = {}

PathGenerator.__index = PathGenerator

--[[
@param tile Tile
@param seed  integer
]]--
function PathGenerator:generate(tile, seed)
  self:generateWall(tile, seed)
end


function PathGenerator:generateWall(tile, seed)
  WallGenerator:generate(tile, seed)
  ColumnGenerator:generator(tile, seed)
end
    