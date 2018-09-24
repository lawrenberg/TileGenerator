require 'Cell'
require 'CellType'

SquareTile = {}

SquareTile.__index = SquareTile

function SquareTile:create(width, height, cellSize)
  assert(width == height, "A square requires that all sides are equal")
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

function SquareTile:initiateGrid()
  for i=1, self.cellHeightLength do
    self.grid[i] = {}
    for j=1,self.cellWidthLength do
      local cell = nil
      self:updateCell(cell, i, j)
    end
  end
end
function SquareTile:refresh()
  for i=1, self.cellHeightLength do
    self.grid[i] = {}
    for j=1,self.cellWidthLength do
      local cell = Cell:create(CellType.PATHWAY)
      self:updateCell(cell, i, j)
    end
  end
end

function SquareTile:display()
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

function SquareTile:getWidth()
  return self.width
end

function SquareTile:getHeight()
  return self.height
end

function SquareTile:getCellContent(row, column)
  return self.grid[row][column]
end

function SquareTile:getCellSize()
  return self.cellSize
end

function SquareTile:updateCell(cell, row, column)
  self.grid[row][column] = cell
end

function SquareTile:getCellHeightLength()
  return self.cellHeightLength
end

function SquareTile:getCellWidthLength()
  return self.cellWidthLength
end

function SquareTile:describe()
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

function SquareTile:setHasWalls(hasWall)
  self.hasWalls = hasWall
end

function SquareTile:getHasWalls()
  return self.hasWalls
end


function SquareTile:setWallCount(count)
  self.noOfWalls = count
end

function SquareTile:getWallCount()
  return self.noOfWalls
end


function SquareTile:setHasDoors(hasDoor)
  self.hasDoors = hasDoor
end

function SquareTile:setDoorCount(count)
  self.noOfDoors = count
end

function SquareTile:getDoorCount()
  return self.noOfDoors
end


function SquareTile:getHasDoors()
  return self.hasDoors
end

function SquareTile:getWallAreas()
  return self.wallAreas
end

function SquareTile:getDoorAreas()
  return self.doorAreas
end

function SquareTile:addWallArea(area)
  if not self:getHasWalls() then
    self:setHasWalls(true)
  end
  table.insert(self:getWallAreas(), area)
  self:setWallCount(#self.wallAreas)
end

function SquareTile:addDoorArea(area)
  if not self:getHasDoors() then
    self:setHasDoors(true)
  end
  
  table.insert(self:getDoorAreas(), area)
  self:setDoorCount(#self.doorAreas)
end

function SquareTile:setSeed(seed)
  self.seed = seed
end

function SquareTile:getSeed()
  return self.seed
end

