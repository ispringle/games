local love = require('love')
local cam = require("modules.hump.camera")
local CameraSystem = ECS.System({
  pool = {"player", "position", "camera"}
})

function CameraSystem:init()
  self.pool.onEntityAdded = function(_, e)
    CAMERA = cam.new(e.position.actual.x, e.position.actual.y, e.camera.zoom or 1)
    CAMERA.smoother = function(dx, dy)
      local dt = love.timer.getDelta()
      return dx * dt, dy * dt
    end
  end
end

function CameraSystem:update()
  for _, e in ipairs(self.pool) do
    local new_x, new_y = e.position.grid.x / CAMERA.x, e.position.actual.y / CAMERA.y
    CAMERA:move(new_x, new_y)
  end
end

function CameraSystem:cameraAttach()
  if CAMERA then
    CAMERA:attach()
  end
end

function CameraSystem:cameraDetach()
  if CAMERA then
    CAMERA:detach()
  end
end

return CameraSystem
