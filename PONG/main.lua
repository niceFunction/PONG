paddle = require "paddle"
Manager = require "gameManager"
Ball = require "ball"
-- https://love2d.org/forums/viewtopic.php?t=3885
-- screenshake: https://love2d.org/forums/viewtopic.php?t=81637

function love.load(arg)
  Ball:initialize_ball()
end

function love.update(dt)
  Paddle:update(dt)
  Manager:update(dt)
  Ball:update(dt)
end

function love.draw()
  Manager:draw()

  Paddle:draw()
  Ball:draw()
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
end
