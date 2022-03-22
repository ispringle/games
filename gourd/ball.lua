local love = require'love'

local M = {}

function M.update(entity, state, dt)
  local max_x, max_y = love.graphics.getDimensions()

  local new_x = entity.x + (entity.speed * dt) * entity.vx
  local new_y = entity.y + (entity.speed * dt) * entity.vy

  if new_x >= max_x - entity.width then
    new_x = max_x - entity.width
    entity.vx = entity.vx * -1
  elseif new_x <= 0 then
    new_x = 0
    entity.vx = entity.vx * -1
  end

  if new_y >= max_y - entity.height then
    new_y = max_y - entity.height
    entity.vy = entity.vy * -1
  elseif new_y <= 0 then
    new_y = 0
    entity.vy = entity.vy * -1
  end

  entity.x = new_x
  entity.y = new_y

  return entity
end

return M
