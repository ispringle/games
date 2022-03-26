local position = ECS.Component("position", function(c, x, y)
  x = x * CONST.SPRITE_SIZE
  y = y * CONST.SPRITE_SIZE
  c.grid = {
    x = x or 0,
    y = y or 0,
  }
  c.actual = {
    x = x or 0,
    y = y or 0,
  }
  c.next = {
    x = x or 0,
    y = y or 0,
  }
end)

return position
