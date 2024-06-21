local Constants = require 'utils.constants'
local Paddle = {}
Paddle.__index = Paddle -- important to lookup methods in a class

function Paddle:new(x, y, width, height)
  local paddle = {}
  setmetatable(paddle, Paddle) -- need to instantiate the class
  paddle.x = x
  paddle.y = y
  paddle.width = width
  paddle.height = height

  paddle.dy = 0 --speed of the paddle going on the y axis
  paddle.dx = 0 -- speed of the paddle going on the x axis

  paddle.update = self.update
  paddle.render = self.render
  return paddle
end

function Paddle:update(dt)
  if self.dy < 0 then
    -- we want to figure out the position of the y axis plus the speed of the paddle times the frame per second
    -- by figuring out the max number, we make sure the paddle doesn't go out of the screen
    self.y = math.max(0, self.y + self.dy * dt)
  else
    -- we want to make sure the paddle doesn't go out of the screen on the bottom
    -- We are looking at the bottom of the paddle position vs the top on the paddle position.
    -- which ever one is the lowest, we are going to use that as the y axis
    self.y = math.min(Constants.VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
  end

  if self.dx < 0 then
    self.x = math.max(0, self.x + self.dx * dt)
  else
    self.x = math.min(Constants.VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
  end
end

function Paddle:render()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Paddle
