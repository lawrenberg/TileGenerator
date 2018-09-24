require "boot.starter"
require "Tile"
require "Generator"

local tile = Tile:create(675, 675, 15)
Logger:info("Generating tile 1")
Generator:generate("path", tile)
 Logger:debug("\n" .. tile:display(), {describeTile = tile:describe()})
--Logger:debug(tile:display())

Logger:unload()