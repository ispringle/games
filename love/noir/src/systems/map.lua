local love = require('love')
local MapSystem = ECS.System({
  pool = { "map" }
})

function MapSystem:renderMap()
  local s = CONST.SPRITE_SIZE
  for _, e in ipairs(self.pool) do
    local map = e.map.map
    for y = 1, #map do
      for x = 1, #map[y] do
        if map[y][x] == 1 then
          local real_x, real_y = x - 1 , y - 1
          love.graphics.rectangle("line", real_x * s, real_y * s, s, s)
        end
      end
    end
  end
end

return MapSystem
