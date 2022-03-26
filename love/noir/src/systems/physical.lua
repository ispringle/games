local PhysicalSystem = ECS.System({
  pool = {"position", "physical"}
})

function PhysicalSystem:init()
  self.pool.onEntityAdded = function(_, e)
    BUMPWORLD:add(e, e.position.grid.x, e.position.grid.y, CONST.SPRITE_SIZE, CONST.SPRITE_SIZE)
  end

  self.pool.onEntityRemoved = function(_, e)
    BUMPWORLD:remove(e)
  end
end

-- function PhysicalSystem:update()
--   for _, e in ipairs(self.pool) do
--     if not e.collidable.can_collide then return end
--     if not BUMPWORLD:hasItem(e) then return end
--     local new_x, new_y
--     if e.position.next.x ~= 0 or e.position.next.y ~= 0 and not e.moveable.can_move then
--       new_x, new_y, _, _ = BUMPWORLD:move(e, e.position.next.x, e.position.next.y)
--     end
--     e.position.actual.x = new_x
--     e.position.actual.y = new_y
--   end
-- end

return PhysicalSystem
