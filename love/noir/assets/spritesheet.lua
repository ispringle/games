local X, Y, SPRITE_SIZE = 15, 15, 16

local sprites = {}
local tile_n = 0
for y = 0, Y, 1 do
  for x = 0, X, 1 do
    tile_n = tile_n + 1
    sprites["tile"..tile_n] = {
      x = x * SPRITE_SIZE,
      y = y * SPRITE_SIZE,
      w = SPRITE_SIZE,
      h = SPRITE_SIZE
    }
  end
end

return {
  image = "assets/tileset.png",
  sprites = sprites
}
