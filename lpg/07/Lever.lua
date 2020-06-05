local GameState = require('GameState')
local const = require('const')

local mt = {}
mt.__index = mt

function mt:update()
  self.touches_hero = GameState.getCurrent().world:check(self, 'is_hero')
end

function mt:draw()
  local x = self.x + self.w/2
  local y = self.y + self.h/2
  local w = self.w/2 - 3
  local h = 8
  love.graphics.circle('line', x, y, w, h)

  if self.is_on then
    w = self.w/2 - 5
    love.graphics.circle('line', x, y, w, h)
  end

  if self.touches_hero then
    x = self.x - 100
    y = self.y - 32
    local limit = self.w + 200
    love.graphics.printf('[E]', x, y, limit, 'center')
  end
end

function mt:onHeroAction()
  self:toggle()
end

function mt:toggle()
  self.is_on = not self.is_on

  local floors = GameState.getCurrent().world:find('all', 'is_toggle_floor')
  for i, floor in ipairs(floors) do
    floor:toggle()
  end
end

return {
  new = function(x, y, world)
    return setmetatable({
      is_lever = true,
      is_actable = true,
      world = world,
      x = x,
      y = y,
      w = const.tilesize,
      h = const.tilesize,
    }, mt)
  end
}
