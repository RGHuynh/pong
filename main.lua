local push = require 'libraries.push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    resizable = false,
    fullscreen = false,
    vsync = true
  })

  -- use for any text look
  local smallFont = love.graphics.newFont('font.ttf', 8)

  ScoreFont = love.graphics.newFont('font.ttf', 32)

  love.graphics.setFont(smallFont)

  love.graphics.setFont(ScoreFont)
  Player1Score = 0
  Player2Score = 0

  Player1Y = 30
  Player2Y = VIRTUAL_HEIGHT - 50

  math.randomseed(os.time())

  BallX = VIRTUAL_WIDTH / 2 - 2
  BallY = VIRTUAL_HEIGHT / 2 - 2

  BallDX = math.random(2) == 1 and 100 or -100
  BallDY = math.random(-50, 50)


  gameState = 'start'
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  elseif key == 'enter' or key == 'return' then
    if gameState == 'start' then
      gameState = 'play'
    else
      gameState = 'start'
      BallX = VIRTUAL_WIDTH / 2 - 2
      BallY = VIRTUAL_HEIGHT / 2 - 2


      BallDX = math.random(2) == 1 and 100 or -100
      BallDY = math.random(-50, 50) * 1.5
    end
  end
end

function love.update(dt)
  if love.keyboard.isDown('w') then
    Player1Y = math.max(0, Player1Y + -PADDLE_SPEED * dt)
  elseif love.keyboard.isDown('s') then
    Player1Y = math.min(VIRTUAL_HEIGHT - 20, Player1Y + PADDLE_SPEED * dt)
  end

  if love.keyboard.isDown('up') then
    Player2Y = math.max(0, Player2Y + -PADDLE_SPEED * dt)
  elseif love.keyboard.isDown('down') then
    Player2Y = math.min(VIRTUAL_HEIGHT - 20, Player2Y + PADDLE_SPEED * dt)
  end


  if gameState == 'play' then
    BallX = BallX + BallDX * dt
    BallY = BallY + BallDY * dt
  end
end

function love.draw()
  -- begin redering at virtual resolution
  push:apply('start')
  love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

  love.graphics.printf('Hello Pong', 0, VIRTUAL_HEIGHT / 2 - 6, VIRTUAL_WIDTH, 'center')

  love.graphics.print(tostring(Player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
  love.graphics.print(tostring(Player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)
  love.graphics.rectangle('fill', 10, Player1Y, 5, 20)

  love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, Player2Y, 5, 20)

  love.graphics.rectangle('fill', BallX, BallY, 5, 5)
  push:apply('end')
end
