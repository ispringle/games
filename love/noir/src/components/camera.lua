local camera = ECS.Component("camera", function(c, zoom)
  c.zoom = zoom or 1
end)

return camera
