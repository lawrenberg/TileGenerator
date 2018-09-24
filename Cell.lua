Cell = {}

Cell.__index = Cell

function Cell:create(cellType)
  local o = {}
  local mt = {__index = self}
  setmetatable(o, mt)
  o.cellType = cellType
  return o
end


function Cell:getCellType()
  return self.cellType
end