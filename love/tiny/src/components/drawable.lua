local Concord = require'lib/concord'

Concord.component("drawable", function(c, sprite, color)
  c.sprite = sprite
  c.color = color
end)
