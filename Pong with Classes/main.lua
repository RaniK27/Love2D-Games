Class = require 'class'
require 'Ball'
require 'Paddle'

window_width = 720
window_height = 500

paddle_speed = 300

player1score = 0
player2score = 0

function love.resize(w,h)
  love.window.setMode(w,h,{resizable=true})

  window_width = w
  window_height = h

  player1=Paddle(10,30,10,60)
  player2=Paddle(window_width-20, window_height-90, 10, 60)
  ball=Ball(window_width/2-5, window_height/2-5, 10, 10)
end

function love.load()
  love.window.setMode(window_width, window_height, {resizable=true})
  love.window.setTitle("Pong")
  math.randomseed(os.time())

  player1 = Paddle(10, 30, 10, 60)
  player2 = Paddle(window_width-20, window_height-90, 10, 60)

  ball = Ball(window_width/2-2, window_height/2-2, 10, 10)

  gameState='start'

end

function love.update(dt)
  if gameState =='serve'then
    ball.dy = math.random(-550,550)
    if servingPlayer == 1 then
      ball.dx = math.random(0,500)
    else
      ball.dx = -math.random(0,500)
    end
  elseif gameState =='play' then

    if ball:collides(player1) then
      ball.dx = -ball.dx
      ball.x = player1.x + 10

      if ball.dy < 0 then
        ball.dy = -math.random(150,550)
      else
        ball.dy = math.random(150,550)
      end
    end

    if ball:collides(player2) then
      ball.dx = -ball.dx
      ball.x = player2.x-10

      if ball.dy<0 then
        ball.dy = -math.random(150,550)
      else
        ball.dy = math.random(150,550)
      end
    end

    if ball.y <= 0 then
      ball.y = 0
      ball.dy = -ball.dy
    end

    if ball.y >= window_height-10 then
      ball.y = window_height-10
      ball.dy = -ball.dy
    end

    if ball.x < 0 then
      servingPlayer = 1
      player2score = player2score + 1
      ball:reset()
      gameState = 'serve'
    end

    if ball.x > window_width then
      servingPlayer = 2
      player1score = player1score + 1
      ball:reset()
      gameState = 'serve'
    end
  end

    if love.keyboard.isDown('w') then
        player1.dy = -paddle_speed
    elseif love.keyboard.isDown('s') then
        player1.dy = paddle_speed
    else
        player1.dy = 0
    end

    if love.keyboard.isDown('up') then
        player2.dy = -paddle_speed
    elseif love.keyboard.isDown('down') then
        player2.dy = paddle_speed
    else
        player2.dy = 0
    end

    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'space' and (player1score < 10 and player2score < 10)then
      if gameState == 'start' then
          gameState = 'play'
      elseif gameState == 'serve' then
          gameState = 'play'
      end
    elseif key == 'return' and (player1score == 10 or player2score == 10) then
      gameState = 'start'
    end
end

function love.draw()
  if gameState == 'start' then
    love.graphics.printf("Pong", 0,window_height/2 - 240,window_width,'center')
  end
  if gameState == 'play' or gameState == 'serve' then
    love.graphics.setLineStyle("smooth")
    love.graphics.setLineWidth(5)
    love.graphics.line(window_width/2,window_height, window_width/2, 0)
  end
  love.graphics.setColor(0,0.5,1)
  player1:draw()
  player2:draw()
  ball:draw()
  love.graphics.setColor(1,1,1)
  love.graphics.print(player1score, window_width/2 - 100, window_height/2)
  love.graphics.print(player2score, window_width/2 + 90, window_height/2)
  if set == 0 and (player1score < 10 and paddle2score < 10) then
    love.graphics.printf("Press Space To Launch The Ball",0, 80,window_width,'center')
  end

  if player1score == 10 then
    gameState = 'start'
      love.graphics.printf("Press Enter To Restart The Game",0,100,window_width,'center')
        love.graphics.setColor(0,1,0)
        love.graphics.printf("Player 1 Won", -150,window_height/2 - 85,window_width,'center')
        love.graphics.setColor(1,0.2,0)
        love.graphics.printf("Player 2 Lost", 150,window_height/2 - 85,window_width,'center')
        love.graphics.setColor(1,1,1)
    end
  if player2score == 10 then
    gameState = 'start'
    love.graphics.printf("Press Enter To Restart The Game", 0, 100, window_width, 'center')
        love.graphics.setColor(1,0.2,0)
        love.graphics.printf("Player 1 Lost", -150,window_height/2 - 85,window_width,'center')
        love.graphics.setColor(0,1,0)
        love.graphics.printf("Player 2 Won", 150,window_height/2 - 85,window_width,'center')
        love.graphics.setColor(1, 1, 1)
    end

end
