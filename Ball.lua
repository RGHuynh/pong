local Constant = require 'utils.constants'
local Ball = {}
Ball.__index = Ball

function Ball:new(x, y)
  local ball = {}
  setmetatable(ball, Ball)
  ball.x = x
  ball.y = y

  ball.dx = math.random(2) == 1 and 100 or -100
  ball.dy = math.random(-50, 50)

  ball.keyPressed = self.keyPressed
  ball.update = self.update
  ball.render = self.render

  return ball
end

function Ball:keyPressed()
  self.x = Constant.VIRTUAL_WIDTH / 2 - 2
  self.y = Constant.VIRTUAL_HEIGHT / 2 - 2

  self.dx = math.random(2) == 1 and 100 or -100
  self.dy = math.random(-50, 50) * 1.5
end

function Ball:update(dt)
  self.x = self.x + self.dx * dt
  self.y = self.y + self.dy * dt
end

function Ball:render()
  love.graphics.rectangle('fill', self.x, self.y, 5, 5)
end

return Ball