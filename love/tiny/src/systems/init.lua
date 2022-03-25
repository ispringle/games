local DIR = (...):gsub('%.init$', '')..'/'

return {
  render = require(DIR..'render'),
  movement = require(DIR..'movement'),
}
