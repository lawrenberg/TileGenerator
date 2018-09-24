require 'Cell'
require 'CellType'

Tile = {}

Tile.__index = Tile

function Tile:create(width, height, cellSize)
  local o = {
    width=0,
    height=0,
    grid={},
    cellSize=0,
    cellWidthLength = 0,
    cellHeightLength = 0,
    hasWalls = false,
    noOfWalls = 0,
    hasDoors = false,
    noOfDoors = 0,
    wallAreas = {},
    doorAreas = {},
    seed = 0
  }
  setmetatable(o, self)
  o.width = width
  o.height = height
  o.cellSize = cellSize
  o.cellWidthLength = width/cellSize
  o.cellHeightLength = height / cellSize
  o:initiateGrid()
  o:refresh()
  return o
end

function Tile:initiateGrid()
  for i=1, self.cellHeightLength do
    self.grid[i] = {}
    for j=1,self.cellWidthLength do
      local cell = nil
      self:updateCell(cell, i, j)
    end
  end
end
function Tile:refresh()
  for i=1, self.cellHeightLength do
    self.grid[i] = {}
    for j=1,self.cellWidthLength do
      local cell = Cell:create(CellType.PATHWAY)
      self:updateCell(cell, i, j)
    end
  end
end

function Tile:display()
    local display = ""
  for i=1, self.cellHeightLength do
    for j=1, self.cellWidthLength do
      local cell = self.grid[i][j]
      local out = ""
      if cell then
        out = cell:getCellType()
      else
        out = "nil"
      end
        
      display = display .. out .. " "
    end
    display = display .. "\n"
  end
  return display
end

function Tile:getWidth()
  return self.width
end

function Tile:getHeight()
  return self.height
end

function Tile:getCellContent(row, column)
  return self.grid[row][column]
end

function Tile:getCellSize()
  return self.cellSize
end

function Tile:updateCell(cell, row, column)
  self.grid[row][column] = cell
end

function Tile:getCellHeightLength()
  return self.cellHeightLength
end

function Tile:getCellWidthLength()
  return self.cellWidthLength
end

function Tile:describe()
  local hasWalls = "false" 
  if self:getHasWalls() then 
    hasWalls = "true" 
  end
  local hasDoors = "false" 
  if self:getHasDoors() then 
    hasDoors = "true" 
  end
  
  local description = {
   width = self.width , 
    height = self.height, 
    cellWidth = self.cellWidthLength ,
    cellHeight = self.cellHeightLength,
    hasWalls=hasWalls,
    wallCount=self:getWallCount()  ,
  wallAreas = self:getWallAreas(),
  hasDoors = hasDoors  ,
  doorCount = self:getDoorCount(),
  doorAreas = self:getDoorAreas(),
  seed = self.seed}
  
  return description
end

function Tile:setHasWalls(hasWall)
  self.hasWalls = hasWall
end

function Tile:getHasWalls()
  return self.hasWalls
end


function Tile:setWallCount(count)
  self.noOfWalls = count
end

function Tile:getWallCount()
  return self.noOfWalls
end


function Tile:setHasDoors(hasDoor)
  self.hasDoors = hasDoor
end

function Tile:setDoorCount(count)
  self.noOfDoors = count
end

function Tile:getDoorCount()
  return self.noOfDoors
end


function Tile:getHasDoors()
  return self.hasDoors
end

function Tile:getWallAreas()
  return self.wallAreas
end

function Tile:getDoorAreas()
  return self.doorAreas
end

function Tile:addWallArea(area)
  if not self:getHasWalls() then
    self:setHasWalls(true)
  end
  table.insert(self:getWallAreas(), area)
  self:setWallCount(#self.wallAreas)
end

function Tile:addDoorArea(area)
  if not self:getHasDoors() then
    self:setHasDoors(true)
  end
  
  table.insert(self:getDoorAreas(), area)
  self:setDoorCount(#self.doorAreas)
end

function Tile:setSeed(seed)
  self.seed = seed
end

function Tile:getSeed()
  return self.seed
end

