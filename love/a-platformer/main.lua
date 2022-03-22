local GameState = require('GameState')
local const = require('const')
local push = require('push')


function love.load()
  -- window size/resolution
  push:setupScreen(const.virtual_width, const.virtual_height,
                   const.window_width, const.window_height)
  push:setBorderColor(const.background_color)

  love.graphics.setBackgroundColor(const.background_color)
  love.graphics.setDefaultFilter('nearest', 'nearest')
  GameState.setCurrent('Play', 1)
end

function love.update(dt)
  GameState.getCurrent():update(dt)
  GameState.update()
end

function love.draw()
  push:start()

  GameState.getCurrent():draw()

  push:finish()
end
