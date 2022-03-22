local Hero = require('Hero')
local Level = require('Level')
local World = require('World')

local hero, level, world

function love.load()
  world = World.new()
  hero = Hero.new(10,10, world)
  level = Level.new()

  world:add(hero)
  for i, v in ipairs(level.tiles) do
    world:add(v)
  end
end

function love.update(dt)
  hero:update(dt)
end

function love.draw()
  hero:draw()
  level:draw()
end
