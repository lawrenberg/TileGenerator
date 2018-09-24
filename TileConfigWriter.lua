TileConfigWriter = {
  open = function(file)
    return assert(io.open(file, "w"))
  end,
  close = function(handler)
    if handler == nil then
      io.flush(handler)
      io.close(handler)
    end
  end
}

TileConfigWriter.directory = nil
TileConfigWriter.handler = nil

TileConfigWriter.__index = TileConfigWriter

--[[
Open the directory where the tile configs will be stored
@param directory string
]]--
function TileConfigWriter:config(config)
  local directory = config.directory
  self.directory = directory
end




--[[
@param tile
]]--
function TileConfigWriter:write(tile)
  
    assert(self.directory, "Please pass in the the config by calling config() method before calling write() method")
    
    local fileName = self.directory .. tile:getSeed() .. ".t"
    self.handler = self.open(fileName)
    self.handler:write(self:buildFile(tile))
    self.close(self.handler)
end

function TileConfigWriter:buildFile(tile)
  local file = "<<<<BEGIN>>>>\n"
  file = file .. tile:display()
  file = file .. "<<<<END>>>>\n"
  file = file .. "<<<<DESCRIPTION BEGIN>>>>\n"
  file = file .. Logger:serialize(tile:describe())
  file = file .. "\n"
  file = file .. "<<<<DESCRIPTION END>>>>\n"

  return file
end
