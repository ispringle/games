local love = require'love'

local M = {}

function M.input(up_key, down_key, boost_key, solid_key)
  local direction = 0
  local boosting = false
  local solid = false

  if love.keyboard.isDown(up_key) then
    direction = -1
  elseif love.keyboard.isDown(down_key) then
    direction = 1
  end

  if love.keyboard.isDown(boost_key) then
    boosting = true
  end
  if love.keyboard.isDown(solid_key) then
    solid = true
  end

  return direction, boosting, solid
end

return M
