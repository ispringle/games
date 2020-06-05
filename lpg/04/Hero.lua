-- metatable
local mt = {}
mt.__index = mt

function mt:update(dt)
  local dx, dy = 0, 0
  if love.keyboard.isDown('up') then
    dy = dy - dt * self.speed
  end
  if love.keyboard.isDown('down') then
    dy = dy + dt * self.speed
  end
  if love.keyboard.isDown('left') then
    dx = dx - dt * self.speed
  end
  if love.keyboard.isDown('right') then
    dx = dx + dt * self.speed
  end
  self.world:move(self, self.x + dx, self.y + dy)
end

function mt:draw()
  love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end

return {
  new = function(x, y, world)
    return setmetatable({
        x = x, y = y,
        w = 16, h = 16,
        speed = 220,
        world = world
      }, mt)
  end
}
