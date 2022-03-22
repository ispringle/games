local GameState = require('GameState')

function love.load()
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
