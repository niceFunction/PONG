Paddle = {}
Paddle.Sprite = love.graphics.newImage("paddleSprite.png")
Paddle.playerOnePosX = 20
Paddle.playerOnePosY = 336
Paddle.playerTwoPosX = 780
Paddle.playerTwoPosY = 336
Paddle.originX = Paddle.Sprite:getWidth() / 2
Paddle.originY = Paddle.Sprite:getHeight() / 2
Paddle.clampRoof = 65
Paddle.clampFloor = love.graphics.getHeight()
Paddle.moveSpeed = 12
Paddle.shakeAmountX = 2
Paddle.shakeAmountY = 3
Paddle.playerOneShake = 0
Paddle.playerOneFrame = 1
Paddle.playerTwoShake = 0
Paddle.playerTwoFrame = 1
--Paddle.playerOneShake =

function Paddle:update(dt)

 -- Player One Input
    self.playerOneShake = math.max( self.playerOneShake - dt, 0 )
    self.playerTwoShake = math.max( self.playerTwoShake - dt, 0 )

    if love.keyboard.isDown("w") then
      self.playerOnePosY = self.playerOnePosY - self.moveSpeed
    elseif love.keyboard.isDown("s") then
      self.playerOnePosY = self.playerOnePosY + self.moveSpeed
    end

    -- Player Two Input
    if love.keyboard.isDown("up") then
      self.playerTwoPosY = self.playerTwoPosY - self.moveSpeed
    elseif love.keyboard.isDown("down") then
      self.playerTwoPosY = self.playerTwoPosY + self.moveSpeed
    end

    -- Player One Clamp
    if self.playerOnePosY <= self.clampRoof then
      self.playerOnePosY = self.clampRoof
    elseif self.playerOnePosY >= self.clampFloor then
      self.playerOnePosY = self.clampFloor
    end

    -- Player Two Clamp
    if self.playerTwoPosY <= self.clampRoof then
      self.playerTwoPosY = self.clampRoof
    elseif self.playerTwoPosY >= self.clampFloor then
      self.playerTwoPosY = self.clampFloor
    end

end

function Paddle:draw()
  -- Draw Player One Paddle
  self.playerOneFrame = self.playerOneFrame * -1
  self.playerTwoFrame = self.playerTwoFrame * -1
  love.graphics.draw(self.Sprite,
                     self.playerOnePosX + (self.playerOneShake *
                     self.playerOneFrame * self.shakeAmountX),
                     self.playerOnePosY - 32 + (self.playerTwoShake *
                     self.playerTwoFrame *  self.shakeAmountY),
                     0, 1, 1, self.originX, self.originY)

  -- Draw Player Two Paddle
  love.graphics.draw(self.Sprite,
                     self.playerTwoPosX + (self.playerTwoShake *
                     self.playerTwoFrame *  self.shakeAmountX),
                     self.playerTwoPosY - 32 + (self.playerTwoShake *
                     self.playerTwoFrame *  self.shakeAmountY),
                     0, 1, 1, self.originX, self.originY)
end

return paddle
