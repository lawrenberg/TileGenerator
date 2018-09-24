require 'util.TableUtil'
require 'CellType'
require 'Cell'
require 'Generators.WallGenerator'

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
end
    