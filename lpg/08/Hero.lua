local GameState = require('GameState')
local assets = require('assets')
local const = require('const')

-- consts
local GRAVITY = 40
local JUMP_SPEED = -8

-- metatable
local mt = {}
mt.__index = mt

function mt:update(dt)
  -- if disabled, skip processing
  if self.is_disabled then return end

  local dx, dy = 0, 0
  if love.keyboard.isDown('up') and self:isGrounded() then
    self.vy = JUMP_SPEED
  end
  if love.keyboard.isDown('left') then dx = dx - dt * self.speed end
  if love.keyboard.isDown('right') then dx = dx + dt * self.speed end

  GameState.getCurrent().world:move(self, self.x + dx, self.y + self.vy, 'is_solid')

  self.vy = math.min(self.vy + GRAVITY * dt, 12)
  if self:isGrounded() then self.vy = 0 end

  if love.keyboard.isDown('e') and not self.was_action_pressed_in_previous_frame then
    GameState.getCurrent():trigger('hero:action', self)
  end
  self.was_action_pressed_in_previous_frame = love.keyboard.isDown('e')

  local touchables = GameState.getCurrent().world:find(self, 'is_touchable')
  for _, touchable in ipairs(touchables) do
    touchable:onTouch(self)
  end
end

function mt:draw()
  assets.qdraw(9, self.x, self.y)
end

function mt:isGrounded()
  return GameState.getCurrent().world:check(
    {x = self.x, y = self.y+self.h, w = self.w, h = 1}, 'is_solid'
  )
end

return {
  new = function(x, y, world)
    return setmetatable({
        is_hero = true,
        x = x, y = y,
        w = 16, h = 16,
        vy = 0,
        speed = 220,
        world = world
      }, mt)
  end
}
