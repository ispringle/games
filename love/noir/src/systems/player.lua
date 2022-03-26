local PlayerSystem = ECS.System({
  pool = {"player", "position", "speed"}
})

function PlayerSystem:keypressed(key)
  for _, e in ipairs(self.pool) do
    if key == "up" then
      e.position.grid.y = e.position.grid.y - CONST.SPRITE_SIZE
    elseif key == "down" then
      e.position.grid.y = e.position.grid.y + CONST.SPRITE_SIZE
    elseif key == "left" then
      e.position.grid.x = e.position.grid.x - CONST.SPRITE_SIZE
    elseif key == "right" then
      e.position.grid.x = e.position.grid.x + CONST.SPRITE_SIZE
    end
  end
end

function PlayerSystem:keyreleased()
  -- for _, e in ipairs(self.pool) do
  -- end
end
return PlayerSystem
