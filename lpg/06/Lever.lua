local TILESIZE = 16

local mt = {}
mt.__index = mt

function mt:draw()
  local x = self.x + self.w/2
  local y = self.y + self.h/2
  local w = self.w/2 - 3
  local h = 8
  love.graphics.circle('line', x, y, w, h)
end

return {
  new = function(x, y, world)
    return setmetatable({
      x = x,
      y = y,
      w = TILESIZE,
      h = TILESIZE
    }, mt)
end
}
