--Ball = require "ball"

Background = love.graphics.newImage("PongBackground.png")

Window = {}
Window.Width = love.graphics.getWidth()
Window.Height = love.graphics.getHeight()

Manager = {}
Manager.fontColor = {1 * 0, 1* 0, 1* 0, 0.25}
Manager.scoreFont = love.graphics.newFont("Bubblegum.ttf", 248)
Manager.playerOneScore = 0
Manager.playerTwoScore = 0
Manager.playerOneGoal = 0
Manager.playerTwoGoal = 800

function Manager:player_score()

  if Ball.isAlive then
    -- If Player One Scores
    if Ball.posX + Ball.Sprite:getWidth() > Manager.playerTwoGoal then
      Manager.playerOneScore = Manager.playerOneScore + 1
      Ball.isAlive = false
    end
    -- If Player Two Scores
    if Ball.posX + Ball.Sprite:getWidth() < Manager.playerOneGoal then
      Manager.playerTwoScore = Manager.playerTwoScore + 1
      Ball.isAlive = false
    end
  end

  if Manager.playerOneScore == 9 or Manager.playerTwoScore == 9 then
    love.event.quit()
  end

end

function Manager:update(dt)
    Manager:player_score()
end

function Manager:draw()
  love.graphics.draw(Background, 0, 0)
  love.graphics.setFont(Manager.scoreFont, 24)
  love.graphics.setColor(Manager.fontColor)
  love.graphics.print(self.playerOneScore, 200, 200)
  love.graphics.print(self.playerTwoScore, 450, 200)
  love.graphics.setColor(1, 1, 1, 1)
end

return Manager
