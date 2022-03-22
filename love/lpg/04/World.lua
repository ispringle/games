-- World handles game objects and collisions
local mt = {}
mt.__index = mt

function mt:add(item)
  self.items[#self.items + 1] = item
end

local function checkCollision(a, b)
  return a.x < b.x + b.w and
         a.x + a.w > b.x and
         a.y < b.y + b.h and
         a.y + a.h > b.y
end

function mt:move(item, new_x, new_y)
  local prev_x, prev_y = item.x, item.y
  item.x, item.y = new_x, new_y

  for _, other in ipairs(self.items) do
    if other ~= item and checkCollision(item, other) then
      item.x, item.y = prev_x, prev_y
      break
    end
  end
end

return {
  new = function()
    return setmetatable({items = {} }, mt)
  end
}
