local hero = {
  x = 10, y = 10
}

function love.update(dt)
  if love.keyboard.isDown('up') then
    hero.y = hero.y + 2
  end
  if love.keyboard.isDown('down') then
    hero.y = hero.y - 2
  end
  if love.keyboard.isDown('left') then
    hero.x = hero.x - 2
  end
  if love.keyboard.isDown('right') then
    hero.x = hero.x + 2
  end
end

function love.draw()
  love.graphics.rectangle('fill', hero.x, hero.y, 16, 16)
end
