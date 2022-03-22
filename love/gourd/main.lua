local love = require'love'

local set_state = require'gamestate'.set_state
local ball_physics = require'ball'
local paddle_physics = require'paddle'

function love.load()
  State = set_state()
end

function love.update(dt)
  local new_state = State
  local paddle_one = State.paddle_one
  local paddle_two = State.paddle_two
  local ball_one = State.ball_one

  paddle_physics.update(paddle_one, new_state, dt)
  paddle_physics.update(paddle_two, new_state, dt)
  ball_physics.update(ball_one, new_state, dt)

  new_state.paddle_one = paddle_one
  new_state.paddle_two = paddle_two
  new_state.ball_one = ball_one

  State = new_state
end

function love.draw()
  for _, p in ipairs(State.entities) do
    p.color()
    love.graphics.rectangle(p.style, p.x, p.y, p.width, p.height)
    local display_region = 0
    if p.display_region == "top" then
      display_x = 10
    else
      display_x = love.graphics.getDimensions() - 10 - 50
    end
    -- love.graphics.newText(love.graphics.getFont(), p.score, p.boosts, p.solidity)
    love.graphics.newText(love.graphics.getFont(), "hi")
  end
end
