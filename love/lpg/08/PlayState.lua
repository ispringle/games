local GameState = require('GameState')
local Level = require('Level')
local World = require('World')

local mt = {}
mt.__index = mt

function mt:update(dt)
  for _, item in ipairs(self.world.items) do
    if item.update then
      item:update(dt)
    end
  end

  if self.close_t then
    self.close_t = self.close_t - dt
    if self.close_t < 0 then
      GameState.setCurrent('Dead')
    end
  end
end

function mt:draw()
  for _, item in ipairs(self.world.items) do
    item:draw()
  end
end

function mt:trigger(event, actor, data)
  if event == 'hero:kill' then
    local hero = data
    hero.is_disabled = true
    self.close_t = (self.close_t or 1)

  elseif event == 'hero:action' then
    local actables = self.world:find(actor, 'is_actable')
    if actables[1] then
      actables[1]:onHeroAction()
    end
  end
end

return {
  new = function()
    local state = setmetatable({ name = 'play_state' }, mt)
    state.world = World.new()
    state.level = Level.new('map_1', state)
    return state
  end
}
