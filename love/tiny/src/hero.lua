local love = require'love'

local M = {}

function M.new()
  local _, height = love.graphics.getDimensions()
  return {
    x = 0,
    y = 30,
    speed = 10,
  }
end

return M
