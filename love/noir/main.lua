local love = require('love')

-- load libraries
-- require("modules.lovedebug.lovedebug")
local bump = require("modules.bump")
local spritesheet = require("modules.shard.spritesheet")

-- load local modules
GAME = require("src.game")
UTILS = require("src.utils")

-- load main ECS libs
ECS = {}
ECS.Component = require("modules.Concord.concord.component")
ECS.System = require("modules.Concord.concord.system")
ECS.World = require("modules.Concord.concord.world")
ECS.Entity = require("modules.Concord.concord.entity")

-- load ECS tables
COMPONENTS = require("src.components")
SYSTEMS = require("src.systems")
WORLDS = require("src.worlds")
ENTITIES = require("src.entities")

-- CONSTANTS
CONST = {
  SPRITE_SIZE = 16,
}
-- Other Globals
BUMPWORLD = bump.newWorld(CONST.SPRITE_SIZE)
CAMERA = nil -- Placeholder for camera
SPRITESHEET = spritesheet:new("assets/spritesheet.lua")

-- initial load func
function love.load()
  GAME.current = WORLDS.start()
end

-- main loop
function love.update(dt)
  GAME.current:emit("update", dt)
end

-- draw loop
function love.draw()
  GAME.current:emit("cameraAttach")
  GAME.current:emit("renderMap")
  GAME.current:emit("renderSprites")
  GAME.current:emit("cameraDetach")
end

function love.keypressed(key)
  GAME.current:emit("keypressed", key)
end

function love.keyreleased(key)
  GAME.current:emit("keyreleased", key)
end
