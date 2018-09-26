require 'util.TableUtil'
require 'CellType'
require 'Cell'

WallGenerator = {}
WallGenerator.wallSides = {'right', 'left', 'top', 'bottom'}
WallGenerator.wallSizeInPixels = 140
WallGenerator.maxNoOfWalls = 3
WallGenerator.doorWidthInPixels = 30

WallGenerator.__index = WallGenerator

--[[
@param tile Tile
@param seed  integer
]]--
function WallGenerator:generate(tile, seed)
  tile:setSeed(seed)
  self:generateWall(tile, seed)
  self:generateDoor(tile, seed)
end

--[[
@param tile Tile
@param seed  integer
]]--
function WallGenerator:generateWall(tile, seed)
  --PathTile
  --PathTile - build wall?
  math.randomseed(seed)
  Logger:debug("Seed", {seed = seed})
  local buildWall = math.random(0,1)
  
  Logger:debug("Are we building a wall?", {buildWall = buildWall})
  if not buildWall == 1 then
    return
  end
    
    local numberOfWalls = math.random(1, self.maxNoOfWalls)    
    tile:setWallCount(numberOfWalls)
    Logger:debug("Describe tile", {description=tile:describe()})
    Logger:info("Number of columns going to populate with 'w'", {wallSize = wallSize})
    Logger:info("Building ".. numberOfWalls .. " Walls")
    local generatedWalls = {}
    
    for i=1,numberOfWalls do
      local cell =  Cell:create(CellType.WALL)
      local side = nil
      local idx = i
      if numberOfWalls == #self.wallSides then
        side = self.wallSides[i]
      else
        repeat
          --math.randomseed(os.time())
          local idx = math.random(1, #self.wallSides)
          side = self.wallSides[idx]
        until not Table:find(generatedWalls, side)
        table.insert(generatedWalls, side)
      end
      tile:addWallArea(side)
      Logger:info("Going to generate wall", {side = side, sideIndex = idx, wallNo = i})
      local startColumn, endingColumn, startRow, endingRow = self:calculateWallPoint(tile, cell, side)
      self:buildSide(tile, cell, side, startColumn, endingColumn, startRow, endingRow)
    end --end of wall loop
end

--[[
  Generates door cells in the tiles
  @param tile Tile
  @param seed 
]]--
function WallGenerator:generateDoor(tile, seed)
   
   if not tile:getHasWalls() then
     return 
   end
   local context = {seed = seed}
   
   Logger:info("Great we have some walls! Let's see if we want to build some doors.")
   local generatedWalls = {}
   local availableWalls = tile:getWallAreas()
   context['availableWalls'] = availableWalls
    --Do we build some doors?
    local buildDoor = math.random(0,1)
    context['buildDoor?'] = buildDoor
    Logger:info("Are we building a door", context)
    if buildDoor == 0 then
      return
    end
    local noOfDoors = math.random(1, #availableWalls)
    context['noOfDoors'] = noOfDoors
    
    for i=1, noOfDoors do
      local cell = Cell:create(CellType.WALL_D)
      local side = nil
      local idx = i
      if noOfDoors == #availableWalls then
        side = availableWalls[i]
      else
        repeat
         --math.randomseed(os.time())
          local idx = math.random(1, #availableWalls)
          side = availableWalls[idx]
        until not Table:find(generatedWalls, side)
        table.insert(generatedWalls, side)
      end -- end of wall selection if
      context['side'] = side
      context['sideIndex'] = idx
      context['wallNo'] = i
      
      tile:addDoorArea(side)
      Logger:info("Going to generate door", context)
      local startingColumn, endingColumn, startingRow, endingRow = WallGenerator:calculateDoorPoints(tile, cell, side)
      WallGenerator:buildSide(tile, cell, side, startingColumn, endingColumn, startingRow, endingRow)
      
    end
    
    
    
end

--[[
@param tile Tile
@param cell Cell
@param side string
]]--
function WallGenerator:calculateDoorPoints(tile,cell,side)
  local doorCellCount = math.ceil(self.doorWidthInPixels / tile:getCellSize())
  local wallSize = math.ceil(self.wallSizeInPixels / tile:getCellSize()) 
  local centerPointRow = math.ceil(tile:getCellWidthLength() / 2)
  local centerPointColumn = math.ceil(tile:getCellHeightLength() / 2)
  if side == 'top' then
    local buildStartingPoint = centerPointRow - math.floor(doorCellCount/2)
    local startingRow = 1
    local startingColumn = buildStartingPoint
    local endingColumn = buildStartingPoint + doorCellCount
    local endingRow = wallSize
    return startingColumn, endingColumn, startingRow, endingRow
  elseif side == 'left' then
    local buildStartingPoint = centerPointColumn - math.floor(doorCellCount/2)
    local startingRow = buildStartingPoint
    local startingColumn = 1
    local endingRow = buildStartingPoint + doorCellCount
    local endingColumn = wallSize
    return startingColumn, endingColumn, startingRow, endingRow
  elseif side == 'right' then
    local buildStartingPoint = centerPointColumn - math.floor(doorCellCount/2)
    local startingRow = buildStartingPoint
    local startingColumn = (tile:getCellWidthLength() - wallSize) + 1
    local endingRow = buildStartingPoint + doorCellCount
    local endingColumn = tile:getCellWidthLength()
    return startingColumn, endingColumn, startingRow, endingRow
  elseif side == 'bottom' then
    local buildEndingPoint = centerPointRow + math.floor(doorCellCount/2)
    local startingColumn = buildEndingPoint - doorCellCount
    local endingColumn = buildEndingPoint
    local startingRow = (tile:getCellHeightLength() - wallSize) + 1
    local endingRow = tile:getCellHeightLength()
    return startingColumn, endingColumn, startingRow, endingRow
  end
end


--[[
Calculate the starting point of the wall and when it ends inclusively
@return startingColumn, endingColumn, startingRow, endingRow
]]--
function WallGenerator:calculateWallPoint(tile, cell, side)
  local wallSize = math.ceil(self.wallSizeInPixels / tile:getCellSize())
  if side == 'top' then
    local startingColumn = 1
    local startingRow = 1
    local endingColumn = tile:getCellWidthLength()
    local endingRow = wallSize
    return startingColumn, endingColumn, startingRow , endingRow
  elseif side == 'left' then
    local startingColumn = 1
    local endingColumn = wallSize
    local startingRow = 1
    local endingRow = tile:getCellHeightLength()
    return startingColumn, endingColumn, startingRow, endingRow
  elseif side == 'bottom' then
    local startingRow = (tile:getCellHeightLength() - wallSize) + 1
    local endingRow = tile:getCellHeightLength()
    local startingColumn = 1
    local endingColumn = tile:getCellWidthLength()
    return startingColumn, endingColumn, startingRow, endingRow
  elseif side == 'right' then
    local startingColumn = (tile:getCellWidthLength() - wallSize) + 1
    local endingColumn = tile:getCellWidthLength()
    local startingRow = 1
    local endingRow = tile:getCellHeightLength()
    return startingColumn, endingColumn, startingRow, endingRow
  end
end

function WallGenerator:buildSide(tile, cell, side, startingColumn, endingColumn, startingRow, endingRow)
  if side == 'right' then
    self:updateColumns(tile, cell, startingColumn, endingColumn, startingRow, endingRow)
  elseif side == 'left' then
    self:updateColumns(tile, cell, startingColumn, endingColumn, startingRow, endingRow)
  elseif side == 'top' then
    self:updateRows(tile, cell, startingColumn, endingColumn, startingRow, endingRow)
  elseif side == 'bottom' then
    self:updateRows(tile, cell, startingColumn, endingColumn, startingRow, endingRow)
  end
end

function WallGenerator:updateColumns(tile, cell, startingColumn, endingColumn, startingRow, endingRow)
  Logger:info("Building columns", {cellType=cell:getCellType(), startingRow=startingRow, endingRow=endingRow, startingColumn=startingColumn, endingColumn=endingColumn})
  for i = startingColumn,endingColumn do --columns
    for j=startingRow, endingRow do --rows 
      tile:updateCell(cell, j, i)
    end
  end
end

function WallGenerator:updateRows(tile, cell, startingColumn, endingColumn, startingRow, endingRow)
  Logger:info("Building rows", {cellType=cell:getCellType(), startingRow=startingRow, endingRow=endingRow, startingColumn=startingColumn, endingColumn=endingColumn})
  for i = startingRow,endingRow do --rows
    for j=startingColumn, endingColumn do --columns
      tile:updateCell(cell, i, j)
    end
  end
end