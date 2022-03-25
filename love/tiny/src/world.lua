local movesystem = require'src/systems/movement'
local rendersystem = require'src/systems/render'

local Concord = require'lib/concord'

local world = Concord.world()

world:addSystem(movesystem, rendersystem)

return world
