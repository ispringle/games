local TILESIZE = 16

local mt = {}
mt.__index = mt

local map_tiles = {
  width = 20,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  9,0,0,6,0,0,0,0,2,2,0,0,2,2,0,0,0,0,0,0,
  1,1,1,1,1,5,5,5,5,5,5,5,5,5,5,5,5,1,1,1,
}

local TILE_TYPES = {
  [9] = 'Hero',
  [1] = 'Tile',
  [2] = 'ToggleFloor',
  [5] = 'Spikes',
  [6] = 'Lever',
}

local Tile = require('Tile')
local Hero = require('Hero')
local ToggleFloor = require('ToggleFloor')
local Spikes = require('Spikes')
local Lever = require('Lever')

return {
  new = function(world)
    local lvl = setmetatable({ columns = 20, tiles = {} }, mt)

    for i, v in ipairs(map_tiles) do
      local x, y = (i-1) % map_tiles.width * TILESIZE,
                   math.floor((i-1) / map_tiles.width) * TILESIZE

      if TILE_TYPES[v] == 'Tile' then
        world:add( Tile.new(x, y, world) )
      elseif TILE_TYPES[v] == 'Hero' then
        world:add( Hero.new(x, y, world) )
      elseif TILE_TYPES[v] == 'ToggleFloor' then
        world:add( ToggleFloor.new(x, y, world) )
      elseif TILE_TYPES[v] == 'Spikes' then
        world:add( Spikes.new(x, y, world) )
      elseif TILE_TYPES[v] == 'Lever' then
        world:add( Lever.new(x, y, world) )
      end
    end

    return lvl
  end
}
