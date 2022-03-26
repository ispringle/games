local PATH = (...):gsub('%.init$', '')..'/'

--SYSTEMS
return {
  CameraSystem = require(PATH..'camera'),
  PhysicalSystem = require(PATH..'physical'),
  MapSystem = require(PATH..'map'),
  MoveSystem = require(PATH..'move'),
  PlayerSystem = require(PATH..'player'),
  RenderSystem = require(PATH..'render'),
}
