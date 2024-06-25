local push = require 'libraries.push'
local Paddle = require 'Paddle'
local Constants = require 'utils.constants'
local Ball = require 'Ball'

local WINDOW_WIDTH = Constants.WINDOW_WIDTH
local WINDOW_HEIGHT = Constants.WINDOW_HEIGHT
local VIRTUAL_WIDTH = Constants.VIRTUAL_WIDTH
local VIRTUAL_HEIGHT = Constants.VIRTUAL_HEIGHT
local PADDLE_SPEED = Constants.PADDLE_SPEED

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    resizable = true,
    fullscreen = false,
    vsync = true
  })

  -- use for any text look
  SmallFont = love.graphics.newFont('font.ttf', 8)

  ScoreFont = love.graphics.newFont('font.ttf', 32)

  love.graphics.setFont(SmallFont)

  love.graphics.setFont(ScoreFont)
  math.randomseed(os.time())

  Player1Score = 0
  Player2Score = 0

  GameState = 'start'

  Player1 = Paddle:new(10, 30, 5, 20)
  Player2 = Paddle:new(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

  CubeBall = Ball:new(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 5, 5)
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  elseif key == Constants.ENTER or key == Constants.RETURN then
    if GameState == Constants.START then
      GameState = Constants.PLAY
    else
      GameState = Constants.START

      CubeBall:keyPressed()
    end
  end
end

function love.resize(w, h)
  push:resize(w, h)
end

function love.update(dt)
  if love.keyboard.isDown('w') then
    Player1.dy = -PADDLE_SPEED
  elseif love.keyboard.isDown('s') then
    Player1.dy = PADDLE_SPEED
  else
    Player1.dy = 0
  end

  if love.keyboard.isDown('up') then
    Player2.dy = -PADDLE_SPEED
  elseif love.keyboard.isDown('down') then
    Player2.dy = PADDLE_SPEED
  else
    Player2.dy = 0
  end

  if love.keyboard.isDown('a') then
    Player1.dx = -PADDLE_SPEED
  elseif love.keyboard.isDown('d') then
    Player1.dx = PADDLE_SPEED
  end

  if love.keyboard.isDown('left') then
    Player2.dx = -PADDLE_SPEED
  elseif love.keyboard.isDown('right') then
    Player2.dx = PADDLE_SPEED
  end


  if GameState == 'play' then
    CubeBall:update(dt)

    if CubeBall:collide(Player1) then
      CubeBall.dx = -CubeBall.dx + 1.03
      CubeBall.x = Player1.x + 5

      if CubeBall.dy < 0 then
        CubeBall.dy = -math.random(10, 150)
      else
        CubeBall.dy = math.random(10, 150)
      end
    end

    if CubeBall:collide(Player2) then
      CubeBall.dx = -CubeBall.dx * 1.03
      CubeBall.x = Player2.x - 4

      if CubeBall.dy < 0 then
        CubeBall.dy = -math.random(10, 150)
      else
        CubeBall.dy = math.random(10, 150)
      end
    end

    -- ball hitting the top
    if CubeBall.y <= 0 then
      CubeBall.y = 0
      CubeBall.dy = -CubeBall.dy
    end

    -- ball hitting the bottom
    if CubeBall.y >= VIRTUAL_HEIGHT - 4 then
      CubeBall.y = VIRTUAL_HEIGHT - 4
      CubeBall.dy = -CubeBall.dy
    end
  end


  -- Score
  if CubeBall.x < 0 then
    Player2Score = Player2Score + 1
    GameState = 'start'
    CubeBall:keyPressed()
  end

  if CubeBall.x > VIRTUAL_WIDTH then
    Player1Score = Player1Score + 1
    GameState = 'start'
    CubeBall:keyPressed()
  end

  Player1:update(dt)
  Player2:update(dt)
end

function love.draw()
  -- begin redering at virtual resolution
  push:apply('start')
  love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

  love.graphics.printf('Hello Pong', 0, VIRTUAL_HEIGHT / 2 - 6, VIRTUAL_WIDTH, 'center')

  love.graphics.setFont(ScoreFont)
  love.graphics.print(tostring(Player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
  love.graphics.print(tostring(Player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

  CubeBall:render()
  Player1:render()
  Player2:render()

  love.graphics.setFont(SmallFont)
  love.graphics.setColor(0, 255, 0, 255)
  love.graphics.print('FPS ' .. tostring(love.timer.getFPS()), 10, 10)
  push:apply('end')
end
