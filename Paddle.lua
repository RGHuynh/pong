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
  paddle.dy = 0

  return paddle
end

function Paddle:update(dt)
  if self.dy < 0 then
    self.y = math.max(0, self.y + self.dy * dt)
  else
    self.y = math.min(Constants.VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
  end
end

function Paddle:render()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Paddle
