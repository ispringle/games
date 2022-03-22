local GameState = require('GameState')
local const = require('const')

local mt = {}
mt.__index = mt

function mt:draw()
  local x = self.x + self.w/2
  local y = self.y + self.h/2
  local w = self.w/2
  local h = 4
  love.graphics.circle('line', x, y, w, h)
end

function mt:onTouch(other)
  if other.is_hero then
    GameState.getCurrent():trigger('hero:kill', self, other)
  end
end

return {
  new = function(x, y, world)
    return setmetatable({
      is_touchable = true,
      x = x,
      y = y,
      w = const.tilesize,
      h = const.tilesize,
    }, mt)
end
}
