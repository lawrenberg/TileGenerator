require "boot.starter"
require "Tile"
require "Generator"
require "TileConfigWriter"
require "util.TimeUtil"

for i=1, 20 do
  local tile = Tile:create(675, 675, 15)
  TileConfigWriter:config({directory = "storage/generated_tiles/"})

  Generator:generate("path", tile)
  TileConfigWriter:write(tile)
  Logger:debug("\n" .. tile:display(), {describeTile = tile:describe()})
  sleep(10)
end

Logger:unload()