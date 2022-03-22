function CheckCollision(x1, y1, w1, h1, x2, y2, w2, h2)
  return  x1 < x2+w2 and
          x2 < x1+w1 and
          y1 < y2+h2 and
          y2 < y1+h1
end

function DrawBackground(tileMap, tiles)
  for _, tile in pairs(tileMap) do
      love.graphics.drawLayer(tiles, tile.num+1, tile.x, tile.y)
  end
end

function NewTileMap(tileWidth, tileHeight, totalTiles)
  local tiles = {}
  local y = 0 - tileHeight
  for i = 0, love.graphics.getHeight() / tileHeight + 1 do
    local x = 0
    for j=0,4 do
      rn = math.random(0, totalTiles - 1)
      local tile = {}
      tile.num = rn
      tile.x = x
      tile.y = y
      table.insert(tiles, tile)
      x = x + tileWidth
    end
    y = y + tileHeight
  end
  return tiles
end

function love.load(arg)
  -- Background
  backgroundSpeed = 25
  local tileWidth = 120
  tileHeight = 140
  local totalTiles = 5
  local images = {}
  for i=0, totalTiles - 1 do
    table.insert(
      images,
      'assets/background' .. i .. '.png'
      )
  end
  tiles = love.graphics.newArrayImage(images)

  --Player
  player = {x = 200, y = 710, speed = 150, img = nil}
  player.img = love.graphics.newImage('assets/player.png')

  -- Bullets
  canShoot = true
  canShootTimerMax = 0.2
  bulletImg = love.graphics.newImage('assets/bullet.png')

  -- Enemies
  createEnemyTimerMax = 0.4
  enemyImg = love.graphics.newImage('assets/enemy.png')

  function reset()
    tilesMap = NewTileMap(tileWidth, tileHeight, totalTiles)

    player.x = 200
    player.y = 710
    isAlive = true
    score = 0

    bullets = {}
    canShootTimer = canShootTimerMax

    enemies = {}
    createEnemyTimer = createEnemyTimerMax
  end

  reset()
end

function love.keypressed(key)
  -- Exit game
  if key == "escape" then
    love.event.quit()
  elseif key == "t" then
    debug.debug()
  end

  if key == 'r' and not isAlive then
    reset()
  end

end

function love.update(dt)
  -- Background Movement
  for i, tile in ipairs(tilesMap) do
    tile.y = tile.y + (backgroundSpeed * dt)
    if tile.y > love.graphics.getHeight() then
      tile.y = 0 - tileHeight
     end
   end
  

  -- Player movement
  if love.keyboard.isDown('left', 'a')
  and player.x > 0 then
    player.x = player.x - (player.speed*dt)
  elseif love.keyboard.isDown('right', 'd')
  and player.x < (love.graphics.getWidth() - player.img:getWidth()) then
    player.x = player.x + (player.speed*dt)
  end

  -- Bullet movement
  canShootTimer = canShootTimer - (1 * dt)
  if canShootTimer < 0 then
    canShoot = true
  end

  if love.keyboard.isDown('space', 'rctrl', 'lctrl') and canShoot then
    newBullet = {
      x = player.x + (player.img:getWidth()/2),
      y = player.y,
      img = bulletImg
    }
    table.insert(bullets, newBullet)
    canShoot = false
    canShootTimer = canShootTimerMax
  end

  for i, bullet in ipairs(bullets) do
    bullet.y = bullet.y - (250 * dt)
    if bullet.y < 0 then
      table.remove(bullets, i)
    end
  end

  -- Enemy movement
  createEnemyTimer = createEnemyTimer - (1 * dt)
  if createEnemyTimer < 0 then
    createEnemyTimer = createEnemyTimerMax
    rn = math.random(10, love.graphics.getWidth() - 10)
    newEnemy = {
      x = rn,
      y = -10,
      img = enemyImg
    }
    table.insert(enemies, newEnemy)
  end

  for i, enemy in ipairs(enemies) do
    enemy.y = enemy.y + (200 * dt)
    if enemy.y > 850 then
       table.remove(enemies, i)
     end
   end

   -- Collision
   for i, enemy in ipairs(enemies) do
     for j, bullet in ipairs(bullets) do
       if CheckCollision(
           enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(),
           bullet.x, bullet.y, bullet.img:getWidth(), bullet.img:getHeight()) then
        table.remove(bullets, j)
        table.remove(enemies, i)
        score = score + 1
      end
    end
    if CheckCollision(
           enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(),
           player.x, player.y, player.img:getWidth(), player.img:getHeight())
         and isAlive then
         table.remove(enemies, i)
         isAlive = false
    end
  end
end

function love.draw(dt)
  ---- Background
  DrawBackground(tilesMap, tiles)

  -- Player
  if isAlive then
    love.graphics.draw(player.img, player.x, player.y)
  else
    love.graphics.print(
      "Press 'R' to restart",
      love.graphics.getWidth() / 2 - 50,
      love.graphics.getHeight() / 2 - 10
    )
  end

  -- Bullets
  for i, bullet in ipairs(bullets) do
    love.graphics.draw(bullet.img, bullet.x, bullet.y)
  end

  -- Enemies
  for i, enemy in ipairs(enemies) do
    love.graphics.draw(enemy.img, enemy.x, enemy.y)
  end

  -- Score
  love.graphics.print(
    "Score: " .. score,
    10,
    10
  )
end
