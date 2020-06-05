-- consts
local GRAVITY = 40
local JUMP_SPEED = -8

-- metatable
local mt = {}
mt.__index = mt

function mt:update(dt)
  local dx, dy = 0, 0
  if love.keyboard.isDown('up') then self.vy = JUMP_SPEED end
  if love.keyboard.isDown('left') then dx = dx - dt * self.speed end
  if love.keyboard.isDown('right') then dx = dx + dt * self.speed end
  self.vy = math.min(self.vy + GRAVITY * dt, 12)
  self.world:move(self, self.x + dx, self.y + self.vy)

  if self:isGrounded() then self.vy = 0 end
end

function mt:draw()
  love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end

function mt:isGrounded()
  return self.world:check({x = self.x, y = self.y+self.h, w = self.w, h = 1})
end

return {
  new = function(x, y, world)
    return setmetatable({
        x = x, y = y,
        w = 16, h = 16,
        vy = 0,
        speed = 220,
        world = world
      }, mt)
  end
}
