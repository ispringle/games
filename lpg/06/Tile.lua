local TILESIZE = 16

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
      x = x,
      y = y,
      w = TILESIZE,
      h = TILESIZE
    }, mt)
end
}
