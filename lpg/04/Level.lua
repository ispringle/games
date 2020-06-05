local TILESIZE = 16

local mt = {}
mt.__index = mt

function mt:draw()
  for _, tile in ipairs(self.tiles) do
    love.graphics.rectangle('line', tile.x, tile.y, tile.w, tile.h)
  end
end

local map_tiles = {
  width = 16,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
}

return {
  new = function()
    local lvl = setmetatable({ tiles = {} }, mt)
    for i, v in ipairs(map_tiles) do
      if v > 0 then
        lvl.tiles[#lvl.tiles+1] = {
          x = ((i-1) % map_tiles.width) * TILESIZE,
          y = math.floor((i-1) / map_tiles.width) * TILESIZE,
          w = TILESIZE,
          h = TILESIZE
        }
      end
    end
    return lvl
  end
}
