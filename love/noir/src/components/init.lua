local PATH = (...):gsub('%.init$', '')..'/'

--COMPONENTS
return {
  camera = require(PATH..'camera'),
  map = require(PATH..'map'),
  physical = require(PATH..'physical'),
  player = require(PATH..'player'),
  position = require(PATH..'position'),
  render = require(PATH..'render'),
  speed = require(PATH..'speed'),
  sprite = require(PATH..'sprite'),
  velocity = require(PATH..'velocity'),
}
