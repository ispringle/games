function love.load()
  x = 400
  y = 300
  speed = 10
end

function love.keypressed(key)
  if key == 'w' or key == 'up' then
    y = y - speed
  elseif key == 's' or key == 'down' then
    y = y + speed
  elseif key == 'a' or key == 'left' then
    x = x - speed
  elseif key == 'd' or key == 'right' then
    x = x + speed
  elseif key == 'escape' then
    love.event.quit()
  end
end

function love.draw()
  love.graphics.print("Hello, Löve!", x, y)
end
