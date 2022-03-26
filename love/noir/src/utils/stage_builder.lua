return function(map, world)
  local sprites = {}

  for y = 1, #map do
    for x = 1, #map[y] do
      local tile = {}
      if map[y][x] ~= 0 then
        tile = ECS.Entity(world)
          :give("physical", false)
          :give("render")
          :give("sprite", map[y][x])
          :give("position", y - 1, x - 1)
      else
        tile = ECS.Entity(world)
          :give("render")
          :give("sprite", 51)
          :give("position", y - 1, x - 1)
      end
      table.insert(sprites, tile)
    end
  end

  return sprites
end
