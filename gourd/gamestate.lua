local love = require'love'

local start_width = 10
local start_height = 40
local start_speed = 100
local start_boost = 3
local boost_multiplier = 10
local start_solidity = 3
local offset = 10

local M = {}

local N = {
  ghost_style = "line",
  solid_style = "fill",
  default_cooldown = 5,
}

function N.new_paddle(y, keys, color_func, ai, display_region, other)
  return {
    style = N.ghost_style,
    color = color_func,
    x = offset,
    y = y,
    vx = 0,
    vy = 0,
    width = start_width,
    height = start_height,
    speed = start_speed,
    is_solid = false,
    other = other,
    up_key = keys["up"],
    down_key = keys["down"],
    boost_key = keys["boost"],
    solid_key = keys["solid"],
    ai = ai,
    boosts = start_boost,
    max_boosts = start_boost,
    boost_multiplier = boost_multiplier,
    solidity = start_solidity,
    score = 0,
    display_region = display_region,
  }
end

function N.new_ball(x, y)
  return {
    style = N.solid_style,
    color = function() love.graphics.setColor(1, 1, 1) end,
    x = x,
    y = y,
    vx = 1,
    vy = 1,
    width = 10,
    height = 10,
    speed = start_speed,
    is_solid = true,
  }
end

function M.set_state()
  local window_width, window_height = love.graphics.getDimensions()

  N.paddle_one = N.new_paddle(offset, {
    up = "w",
    down = "s",
    boost = "a",
    solid = "d",
  },
  function() love.graphics.setColor(1, 0, 0) end,
  false, {}, "top")

  N.paddle_two = N.new_paddle(window_height - offset - start_height, {
    up = "up",
    down = "down",
    boost = "left",
    solid = "right",
  },
  function() love.graphics.setColor(0, 0, 1) end,
  true, "bottom", N.paddle_one)

  N.paddle_one.other = N.paddle_two

  N.ball_one = N.new_ball(window_width / 2, window_height / 2)

  N.entities = {
    N.paddle_one,
    N.paddle_two,
    N.ball_one,
  }

  return N
end

return M
