local Hero = require('Hero')
local hero = Hero.new(10,10)

function love.update(dt)
  hero:update(dt)
end

function love.draw()
  hero:draw()
end
