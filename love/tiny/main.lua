local love = require'love'

-- local Camera = require'lib/hump/camera'
local Concord = require'lib/concord'

-- local input = require'input'
-- local hero_maker = require'hero'


SPRITE_SIZE = 16

function love.load()
  require'src/components'
  world = require'src/world'
  hero = Concord.entity(world)
    :give("position", 200, 200)
    :give("velocity", 50, 50)
    :give("drawable", "", "")
  -- camera = Camera(hero.x, hero.y)
  -- camera:zoom(2)
  -- camera.smoother = function(dx, dy)
  --   local dt = love.timer.getDelta()
  --   return dx*dt, dy*dt
  -- end
end

function love.update(dt)
  world:emit("update", dt)
  -- input:update()
  --
  -- local vx, _ = input:get('move')
  -- hero.x = hero.x + (vx * hero.speed) * dt
  --
  -- local cam_dx, cam_dy = hero.x - camera.x, hero.y - camera.y
  -- camera:move(cam_dx / 2, cam_dy / 2)
end

function love.draw()
  world:emit("draw")
  -- camera:attach()
  -- love.graphics.setColor(1, 0, 0)
  -- love.graphics.rectangle("line", hero.x, hero.y, SPRITE_SIZE, SPRITE_SIZE)
  -- camera:detach()
end
