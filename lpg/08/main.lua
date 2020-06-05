local GameState = require('GameState')

function love.load()
  love.graphics.setBackgroundColor(0x1d, 0x21, 0x2d)
  love.graphics.setDefaultFilter('nearest', 'nearest')
  GameState.setCurrent('Play')
end

function love.update(dt)
  GameState.getCurrent():update(dt)
  GameState.update()
end

function love.draw()
  love.graphics.scale(2, 2)
  GameState.getCurrent():draw()
end
