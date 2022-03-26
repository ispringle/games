local MovementSystem = ECS.System({
  pool = {"position", "speed", "physical"}
})

function MovementSystem:update(dt)
  for _, e in ipairs(self.pool) do
    local pos, speed = e.position, e.speed.speed
    e.position.actual.x, e.position.actual.y = BUMPWORLD:move(e,
      pos.actual.x - ((pos.actual.x - pos.grid.x) * speed * dt),
      pos.actual.y - ((pos.actual.y - pos.grid.y) * speed * dt)
    )
  end
end

return MovementSystem
