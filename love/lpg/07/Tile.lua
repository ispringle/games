local const = require('const')

local mt = {}
mt.__index = mt

function mt:draw()
  local x = self.x
  local y = self.y
  local w = self.w
  local h = self.h
  love.graphics.rectangle('line', x, y, w, h)
end

return {
  new = function(x, y, world)
    return setmetatable({
      is_solid = true,
      x = x,
      y = y,
      w = const.tilesize,
      h = const.tilesize,
    }, mt)
end
}
