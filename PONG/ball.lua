paddle = require "paddle"
Manager = require "gameManager"
Ball = {}

function Ball:initialize_ball()
  Ball.Sprite = love.graphics.newImage("ballSprite.png")
  Ball.posX = love.graphics.getWidth() / 2
  Ball.posY = love.graphics.getHeight() / 2
  Ball.originX = Ball.Sprite:getWidth() / 2
  Ball.originY = Ball.Sprite:getHeight() / 2
  Ball.Speed = 300
  Ball.maxSpeed = 580
  love.math.setRandomSeed(love.timer.getTime())
  Ball.dirX = 0
  local randomValue = love.math.random(0, 1)
  if randomValue == 0 then Ball.dirX = 1 else Ball.dirX = -1 end
  Ball.dirY = 0
  Ball.clampRoof = 16
  Ball.clampFloor = love.graphics.getHeight()
  Ball.isAlive = true

end

function Ball:handlePaddleBounce(isPlayerOne)
  local padHalfWidth = Paddle.Sprite:getWidth() * 0.5
  local padHalfHeight = Paddle.Sprite:getHeight() * 0.5
  local padPosX = 0
  local padPosY = 0
  local paddleOriginOffset = 35

  if isPlayerOne  then
    padPosX = Paddle.playerOnePosX - paddleOriginOffset -- ball origin offset
    padPosY = Paddle.playerOnePosY - padHalfHeight
  else
    padPosX = Paddle.playerTwoPosX + paddleOriginOffset
    padPosY = Paddle.playerTwoPosY - padHalfHeight
  end

  local padToBallX = self.posX - padPosX
  local padToBallY = self.posY - padPosY
  local ballToPadlength = math.sqrt(padToBallX * padToBallX +
                          padToBallY * padToBallY)
    self.dirX = padToBallX / ballToPadlength
    self.dirY = padToBallY / ballToPadlength
end

function Ball:ball_hit_roof()
  if self.posY < self.clampRoof then
    self.posY = self.Sprite:getHeight()
    self.dirY = -self.dirY
    Ball.Speed = Ball.Speed * 1.05
    if Ball.Speed >= Ball.maxSpeed then
      Ball.Speed = Ball.maxSpeed
    end
  end
end

function Ball:ball_hit_floor()
  if (self.posY + self.Sprite:getHeight()) > Window.Height then
    self.posY = Window.Height - self.Sprite:getHeight()
    self.dirY = -self.dirY
    Ball.Speed = Ball.Speed * 1.05
    if Ball.Speed >= Ball.maxSpeed then
      Ball.Speed = Ball.maxSpeed
    end
  end
end

function Ball:ball_hit_player_one()
  local padHalfWidth = Paddle.Sprite:getWidth() * 0.5
  local padHalfHeight = Paddle.Sprite:getHeight() * 0.5
  local ballHalfWidth = self.Sprite:getWidth() * 0.5
  local ballHalfHeight = self.Sprite:getHeight() * 0.5

  if self.posX -ballHalfWidth <=
     Paddle.playerOnePosX + padHalfWidth and
     self.posY >= Paddle.playerOnePosY - Paddle.Sprite:getHeight() and
     self.posY - self.Sprite:getHeight() < Paddle.playerOnePosY then
      Paddle.playerOneShake = 1
      Ball:handlePaddleBounce(true)
      Ball.Speed = Ball.Speed * 1.02
      if Ball.Speed >= Ball.maxSpeed then
        Ball.Speed = Ball.maxSpeed
      end
  end
end

function Ball:ball_hit_player_two()
  local padHalfWidth = Paddle.Sprite:getWidth() * 0.5
  local padHalfHeight = Paddle.Sprite:getHeight() * 0.5
  local ballHalfWidth = self.Sprite:getWidth() * 0.5
  local ballHalfHeight = self.Sprite:getHeight() * 0.5

  if (self.posX + ballHalfWidth) >=
      Paddle.playerTwoPosX - padHalfWidth
      and self.posY >=
      Paddle.playerTwoPosY - Paddle.Sprite:getHeight() and
      self.posY - self.Sprite:getHeight() < Paddle.playerTwoPosY then
        Paddle.playerTwoShake = 1
        Ball:handlePaddleBounce(false)
        Ball.Speed = Ball.Speed * 1.02
        if Ball.Speed >= Ball.maxSpeed then
          Ball.Speed = Ball.maxSpeed
        end
  end
end

-- Update Ball if it's outside the screen
function Ball:reset_ball()
  if self.posX + self.Sprite:getWidth() < 0 or self.posX > Window.Width then
    Ball:initialize_ball()
  end
end

function Ball:update(dt)
  Ball:ball_hit_roof()
  Ball:ball_hit_floor()
  Ball:ball_hit_player_one()
  Ball:ball_hit_player_two()
  Ball:reset_ball()

  self.posX = self.posX + (self.dirX * self.Speed * dt)
  self.posY = self.posY + (self.dirY * self.Speed * dt)

end

function Ball:draw()
  love.graphics.draw(self.Sprite, self.posX, self.posY,
                     0, 1, 1, self.originX, self.originY)
end

return Ball
