local love = require('love')
local RenderSystem = ECS.System({
  pool = {"position", "render"}
})

function RenderSystem:renderSprites()
    for _, e in ipairs(self.pool) do
      local x, y = e.position.actual.x, e.position.actual.y
      if e.sprite then
        SPRITESHEET:draw("tile"..e.sprite.tile, x, y)
        -- e.sprite.draw(x, y)
      else
        local w, h = CONST.SPRITE_SIZE, CONST.SPRITE_SIZE
        love.graphics.rectangle("fill", x, y, w, h)
      end
    end
end

return RenderSystem
