local const = require('const')

local mt = {}
mt.__index = mt

local TILE_TYPES = {
  [9] = require('Hero'),
  [1] = require('Tile'),
  [5] = require('Spikes'),
  [6] = require('Lever'),
  [2] = require('ToggleFloor'),
}

return {
  new = function(lvl_name, game_state)
    local lvl = setmetatable({ columns = 20, tiles = {} }, mt)
    lvl.data = require(lvl_name)

    for i, v in ipairs(lvl.data) do
      local x, y = (i-1) % lvl.columns * const.tilesize,
                   math.floor((i-1) / lvl.columns) * const.tilesize

      if TILE_TYPES[v] then
        game_state.world:add( TILE_TYPES[v].new(x, y, game_state) )
      end
    end

    return lvl
  end
}
