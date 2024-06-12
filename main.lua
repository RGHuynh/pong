local push = require 'libraries.push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243


function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    resizable = false,
    fullscreen = false,
    vsync = true
  })


  smallFont = love.graphics.newFont('font.ttf', 8)

  love.graphics.setFont(smallFont)
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
end

-- function love.update(dt)

-- end

function love.draw()
  push:apply('start')
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

  -- love.graphics.printf('hello world', 0, VIRTUAL_HEIGHT / 2 - 6, VIRTUAL_WIDTH, 'center')

  love.graphics.rectangle('fill', 10, 30, 5, 20)

  love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5, 20)

  love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 5, 5)
  push:apply('end')
end
