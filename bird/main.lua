function newAnimation(img, width, height, duration)
  local animation = {}
  animation.spriteSheet = img
  animation.quads = {}
  for y = 0, img:getHeight() - height, height do
    for x = 0, img:getWidth() - width, width do
      table.insert(
        animation.quads,
        love.graphics.newQuad(
          x, y, width, height, img:getDimensions()
        )
      )
    end
  end
  animation.duration = duration or 1
  animation.currentTime = 0
  return animation
end

function love.load()
  -- Play Area
  playingAreaWidth = 300
  playingAreaHeight = 388
  background = love.graphics.newImage('assets/background.png')

  -- Init Window
  love.window.setMode(playingAreaWidth, playingAreaHeight)

  -- Bird
  birdX = 62
  birdWidth = 30
  birdHeight = 25
  birdImg = love.graphics.newImage('assets/bird.png')
  birdAnimation = newAnimation(birdImg, birdWidth, birdHeight, 1)

  -- Pipes
  pipeWidth = 54
  pipeSpaceHeight = 100

  function newPipeSpaceY()
    local pipeSpaceYMin = 54
    pipeSpaceY = love.math.random(
      pipeSpaceYMin,
      playingAreaHeight - pipeSpaceHeight - pipeSpaceYMin
    )
    return pipeSpaceY
  end

  function reset()
    -- Bird
    birdY = 200
    birdYSpeed = 0

    -- Pipes
    pipe1X = playingAreaWidth
    pipe1SpaceY = newPipeSpaceY()
    pipe2X = playingAreaWidth + ((playingAreaWidth + pipeWidth) / 2)
    pipe2SpaceY = newPipeSpaceY()
    upcomingPipe = 1

    -- Score
    score = 0
  end

  reset()
end

function love.update(dt)
  -- Bird movement rules
  birdYSpeed = birdYSpeed + (516 * dt)
  birdY = birdY + (birdYSpeed * dt)
  birdAnimation.currentTime = birdAnimation.currentTime + dt
  if birdAnimation.currentTime >= birdAnimation.duration then
    birdAnimation.currentTime = birdAnimation.currentTime - birdAnimation.duration
  end

  -- Pipe movement rules
  local function movePipe(pipeX, pipeSpaceY)
    pipeX = pipeX - (60 * dt)
    if (pipeX + pipeWidth) < 0 then
      pipeX = playingAreaWidth
      pipeSpaceY = newPipeSpaceY()
    end

    return pipeX, pipeSpaceY
  end

  pipe1X, pipe1SpaceY = movePipe(pipe1X, pipe1SpaceY)
  pipe2X, pipe2SpaceY = movePipe(pipe2X, pipe2SpaceY)

  -- Collision rules
  function isCollided(pipeX, pipeSpaceY)
    return
    birdX < (pipeX + pipeWidth)
    and
    (birdX + birdWidth) > pipeX
    and (
      birdY < pipeSpaceY
      or
      (birdY + birdHeight) > (pipeSpaceY + pipeSpaceHeight)
    )
  end

  if isCollided(pipe1X, pipe1SpaceY)
  or isCollided(pipe2X, pipe2SpaceY)
  or birdY > playingAreaHeight then
  reset()
  end

  -- Update Score
  local function checkScore(thisPipe, pipeX, otherPipe)
    if upcomingPipe == thisPipe
    and (birdX > (pipeX + pipeWidth)) then
      score = score + 1
      upcomingPipe = otherPipe
    end
  end

  checkScore(1, pipe1X, 2)
  checkScore(2, pipe2X, 1)
end

function love.keypressed(key)
  if key == "escape" then
    -- Exit game
    love.event.quit()
  elseif birdY > 0 then
    -- Flap
    birdYSpeed = -165
  end
end

function love.draw()
  -- Draw background
  love.graphics.setColor(255, 255, 255) --white

  -- Draw bird
  local spriteNum = math.floor(
    birdAnimation.currentTime / birdAnimation.duration * #birdAnimation.quads
  ) + 1
  love.graphics.draw(
    birdAnimation.spriteSheet,
    birdAnimation.quads[spriteNum],
    birdX,
    birdY
  )


  -- Draw pipe
  local function drawPipe(pipeX, pipeSpaceY)
    love.graphics.setColor(.37, .82, .28)
    love.graphics.rectangle(
      'fill',
      pipeX,
      0,
      pipeWidth,
      pipeSpaceY
    )
      love.graphics.rectangle(
      'fill',
      pipeX,
      pipeSpaceY + pipeSpaceHeight,
      pipeWidth,
      playingAreaHeight - pipeSpaceY - pipeSpaceHeight
    )
  end

  drawPipe(pipe1X, pipe1SpaceY)
  drawPipe(pipe2X, pipe2SpaceY)

  -- Draw score
  love.graphics.setColor(1, 1, 1)
  love.graphics.print(
    "Score: " .. score,
    15,
    15
  )

end
