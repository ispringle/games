local love = require'love'

local input = require'input'.input

local M = {}

local function player_movement(entity)
  local dy, boosting, be_solid = input(entity.up_key,
                                       entity.down_key,
                                       entity.boost_key,
                                       entity.solid_key)

  if boosting == true and entity.boosts > 0 then
    dy = dy * entity.speed * entity.boost_multiplier
  else
    dy = dy * entity.speed
  end

  return dy, boosting, be_solid
end

local function ai_movement(entity, ball)
  local vy, boosted, be_solid = 0, false, false
  if entity.y < ball.y then
    vy = 1
  elseif entity.y > ball.y then
    vy = -1
  end

  return vy * entity.speed, boosted, be_solid
end

function M.update(entity, state, dt)
  local ne = entity
  local _, max_y = love.graphics.getDimensions()

  local dy, boosted, be_solid = 0, ne.boosts, false
  if ne.ai == true then
    dy, boosted, be_solid = ai_movement(entity, state.ball_one)
  else
    dy, boosted, be_solid = player_movement(entity)
  end
  local new_y = ne.y + dy * dt

  if boosted then
    ne.boosts = ne.boosts - dt
  else
    ne.boosts = ne.boosts + (dt / 2)
  end
  print(ne.boosts)

  if new_y >= max_y - ne.height then
    new_y = max_y - ne.height
  elseif new_y <= 0 then
    new_y = 0
  end

  if state.ball_one.x - ne.x < 100 then
    ne.style = state.solid_style
    ne.is_solid = true
  elseif be_solid and ne.solidity > 0 then
    ne.style = state.solid_style
    ne.is_solid = true
    ne.solidity = ne.solidity - dt
  else
    ne.style = state.ghost_style
    ne.is_solid = false
    ne.solidity = ne.solidity + (dt / 2)
  end

  if ne.is_solid or ne.other.is_solid then
    -- ne.y within coords of ne.other.y,ne.other.y+ne.other.height
    if (new_y > ne.other.y and new_y < ne.other.y + ne.other.height)
    -- ne.y+ne.height within coords of ne.other.y,ne.other.y+ne.other.height
      or (new_y + ne.height > ne.other.y and new_y + ne.height < ne.other.y + ne.other.height) then
      new_y = ne.y
    end
  end

  ne.y = new_y

  return ne
end

return M
