function love.load()
  love.window.setMode(1000, 1000, {
    resizable = false,
    fullscreen = false,
    vsync = true
  })
end

function love.update()

end

function love.draw()
  love.graphics.printf('hello world', 0, 0, 1000, 'center')
end
