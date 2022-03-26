local physical = ECS.Component("physical", function(c, static)
  c.static = static or false
end)

return physical
