local const = require('const')

local mt = {}
mt.__index = mt

function mt:draw()
  local x, y, w, h
  if self.is_solid then
    x = self.x
    y = self.y
    w = self.w
    h = self.h
    love.graphics.rectangle('line', x, y, w, h)
  end
  x = self.x + self.w/2
  y = self.y + self.h/2
  w = self.w/2
  h = 6
  love.graphics.circle('line', x, y, w, h)
end

function mt:toggle()
  self.is_solid = not self.is_solid
end

return {
  new = function(x, y, world)
    return setmetatable({
      is_toggle_floor = true,
      x = x,
      y = y,
      w = const.tilesize,
      h = const.tilesize,
    }, mt)
end
}
