local Hero = require('Hero')
local Level = require('Level')

local hero = Hero.new(10,10)
local level = Level.new()

function love.update(dt)
  hero:update(dt)
end

function love.draw()
  hero:draw()
  level:draw()
end
