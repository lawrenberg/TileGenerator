require 'Cell'
require 'CellType'
require 'Tile'

PathTile = {}

PathTile.__index = PathTile

function PathTile:create(width, height, cellSize)
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

function PathTile:initiateGrid()
  for i=1, self.cellHeightLength do
    self.grid[i] = {}
    for j=1,self.cellWidthLength do
      local cell = nil
      self:updateCell(cell, i, j)
    end
  end
end
function PathTile:refresh()
  for i=1, self.cellHeightLength do
    self.grid[i] = {}
    for j=1,self.cellWidthLength do
      local cell = Cell:create(CellType.PATHWAY)
      self:updateCell(cell, i, j)
    end
  end
end

function PathTile:display()
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

function PathTile:getWidth()
  return self.width
end

function PathTile:getHeight()
  return self.height
end

function PathTile:getCellContent(row, column)
  return self.grid[row][column]
end

function PathTile:getCellSize()
  return self.cellSize
end

function PathTile:updateCell(cell, row, column)
  self.grid[row][column] = cell
end

function PathTile:getCellHeightLength()
  return self.cellHeightLength
end

function PathTile:getCellWidthLength()
  return self.cellWidthLength
end

function PathTile:describe()
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

function PathTile:setHasWalls(hasWall)
  self.hasWalls = hasWall
end

function PathTile:getHasWalls()
  return self.hasWalls
end


function PathTile:setWallCount(count)
  self.noOfWalls = count
end

function PathTile:getWallCount()
  return self.noOfWalls
end


function PathTile:setHasDoors(hasDoor)
  self.hasDoors = hasDoor
end

function PathTile:setDoorCount(count)
  self.noOfDoors = count
end

function PathTile:getDoorCount()
  return self.noOfDoors
end


function PathTile:getHasDoors()
  return self.hasDoors
end

function PathTile:getWallAreas()
  return self.wallAreas
end

function PathTile:getDoorAreas()
  return self.doorAreas
end

function PathTile:addWallArea(area)
  if not self:getHasWalls() then
    self:setHasWalls(true)
  end
  table.insert(self:getWallAreas(), area)
  self:setWallCount(#self.wallAreas)
end

function PathTile:addDoorArea(area)
  if not self:getHasDoors() then
    self:setHasDoors(true)
  end
  
  table.insert(self:getDoorAreas(), area)
  self:setDoorCount(#self.doorAreas)
end

function PathTile:setSeed(seed)
  self.seed = seed
end

function PathTile:getSeed()
  return self.seed
end

