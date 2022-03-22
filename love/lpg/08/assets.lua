local const = require('const')

local assets, quads, tex = {}, {}, nil

function assets.qdraw(id, x, y)
  local size = const.tilesize
  if not tex then
    tex = love.graphics.newImage('tex.png')
    for y = 0, tex:getHeight()-1, size do
      for x = 0, tex:getWidth()-1, size do
        quads[#quads+1] = love.graphics.newQuad(x, y, size, size, tex:getDimensions())
      end
    end
  end
  love.graphics.draw(tex, quads[id], x, y)
end

return assets
