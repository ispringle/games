local GameState = require('GameState')
local const = require('const')

function love.load()
  love.graphics.setBackgroundColor(const.background_color)
  love.graphics.setDefaultFilter('nearest', 'nearest')
  GameState.setCurrent('Play', 1)
end

function love.update(dt)
  GameState.getCurrent():update(dt)
  GameState.update()
end

function love.draw()
  love.graphics.scale(2, 2)
  GameState.getCurrent():draw()
end
