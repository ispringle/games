local Level = require('Level')
local World = require('World')

local level, world

function love.load()
  world = World.new()
  level = Level.new(world)
end

function love.update(dt)
  for _, item in ipairs(world.items) do
    if item.update then
      item:update(dt, world)
    end
  end
end

function love.draw()
  love.graphics.scale(2, 2)
  for _, item in ipairs(world.items) do
    item:draw()
  end
end
