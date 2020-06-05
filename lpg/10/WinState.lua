local GameState = require('GameState')
local const = require('const')

local mt = {}
mt.__index = mt

function mt:update(dt)
  if love.keyboard.isDown('return') then
    GameState.setCurrent('Play', 1)
  end
end

function mt:draw()
  love.graphics.setColor(const.text_color)
  love.graphics.print('YOU WON!\nPress [ENTER] to restart.', 100, 100)
  love.graphics.setColor(255, 255, 255, 255)
end

function mt:trigger()
end

return {
  new = function()
    return setmetatable({ name = 'win_state' }, mt)
  end
}
