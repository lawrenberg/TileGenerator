ColumnGenerator = {}

ColumnGenerator.__index = ColumnGenerator

function ColumnGenerator:generator(tile, seed)
  local wallAreas = nil
  if tile:getHasWalls() then
    wallAreas = tile:getWallAreas()
  end
end
