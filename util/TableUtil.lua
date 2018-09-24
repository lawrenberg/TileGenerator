Table = {}
Table.__index = Table

function Table:find(table, needle)
    for k,v in pairs(table) do
        if v == needle then
          return true
        end
    end
    return false
end