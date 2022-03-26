local sprite = ECS.Component("sprite", function(c, sprite)
    -- c.draw = function(x, y) SPRITESHEET:draw("tile231", x, y) end
    c.tile = sprite
end)

return sprite
