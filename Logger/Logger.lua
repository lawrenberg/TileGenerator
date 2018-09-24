Logger = {}

Logger.INFO = "INFO"
Logger.ERROR = "ERROR"
Logger.DEBUG = "DEBUG"
Logger.WARNING = "WARNING"

Logger.fileName = nil
Logger.fileObj = nil

Logger.loggingLevel = "ERROR"

Logger.enable = true
Logger.output = true
Logger.flush = true

function Logger:load()
  if self.enable then
    self.fileName = __logFilePath .. "proceduralgeneration" .. os.date("%Y-%m-%d") .. ".log"
    if self.flush then
      os.execute("rm " .. self.fileName)
    end
    self.fileObj = assert(io.open(self.fileName , 'a+'))
    
    if type(self.fileObj) == "string" then
      print("Failed to open file stream")
    end
  end  
end

function Logger:log(level, message, obj)
  if self.enable then
    local date = os.date("%Y-%m-%d %X")
    local context = self:serialize(obj)
    local outputMessage = "[" ..date .. " " .. level .. "]" .." :: " .. message .. ", {context : \"".. context .. "\"}\n"
    self.fileObj:write(outputMessage)
    if self.output then 
      print(outputMessage)
    end
  end
end

function Logger:error(message, obj)
  self:log(Logger.ERROR, message, obj)
end

function Logger:info(message, obj)
  self:log(Logger.INFO, message, obj)
end

function Logger:warn(message, obj)
  self:log(Logger.WARNING, message, obj)
end

function Logger:debug(message, obj)
  self:log(Logger.DEBUG, message, obj)
end


function Logger:unload()
  if self.enable then
    self.fileObj:flush()
    self:info("closing logger file\n")
    self.fileObj:close()
  end
end

function Logger:serialize(obj)
  local json = '{'
  if obj then
    for k,v in pairs(obj) do
      json = json .. '"' .. k ..'"'.. ":"
      if type(v) == "table" then
        json = json .. self:serialize(v)
      elseif type(v) == "string" then
        json = json .. '"' .. v .. '"'
      elseif type(v) == "function" then
      else
        json = json .. v
      end
      json = json .. ','
    end
    --removing extra comma at the end
    if string.sub(json, #json) == "," then
      json = string.sub(json, 1, #json - 1)
    end
    
  end
  json = json .. '}'
  return json
end