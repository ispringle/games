local love = require'love'
local Concord = require'lib/concord'

RenderSpriteSystem = Concord.system({
  pool = {"position", "drawable"}
})

function RenderSpriteSystem:draw()
  for _, e in ipairs(self.pool) do
    print(e)
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", e.position.x, e.position.y, 50, 50)
  end
end

return RenderSpriteSystem
