require 'Generators.PathGenerator'

Generator = {}

Generator.__index = Generator

function Generator:test(tile)
  if true then
print(tile:display())
end
  return

end

--[[
@param type
@param tile
]]--
function Generator:generate(tileType, tile)
  if tileType == 'path' then
    PathGenerator:generate(tile, os.time())
  end
  
end

function Generator:generateWall()
end