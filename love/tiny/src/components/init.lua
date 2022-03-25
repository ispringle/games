local DIR = (...):gsub('%.init$', '')..'/'

return {
  drawable = require(DIR..'drawable'),
  position = require(DIR..'position'),
  velocity =require(DIR..'velocity'),
}
