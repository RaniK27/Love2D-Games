----------gamestates------
gamestart=0
gameend=0
---window config------
window={}
window.width=1200
window.height=700
xm=0
ym=0
------files----
require "Player"
require "enemies"
require "bullet"
require "collision"
require "GUI"
require "HUD"
push =require 'push'

function love.load()
  --love.window.setMode(window.width,window.height)
  love.window.setTitle("Star Endurance")
  wind_x,wind_y=love.window.getMode()
  push:setupScreen(window.width,window.height,wind_x,wind_y,{
     vsync = true,
     fullscreen = true,
     resizable = true,
     pixelperfect=false, highdpi = true ,stretched = true
  })
  math.randomseed(os.time())
  love.profiler = require('profile')
  love.frame=0
  gametitle=love.graphics.newImage('Images/title01.png')
  menuback=love.graphics.newImage('Images/stars2.jpg')
  -------------games states------------------------
  home_door={}
  home_door.image=love.graphics.newImage("Images/home_icon.jpg")
  home_door.x=window.width-100
  home_door.y=25
  home_door.width=home_door.image:getWidth()
  home_door.height=home_door.image:getHeight()
  --------------------------------------------------------
  --------------Audio files------------------------------
  shoot=love.audio.newSource("Sound/Laser Gun Sound Effect.mp3","stream")
  shootpowerup=love.audio.newSource("Sound/Machine-Gun-Automatic-Fire-A-www.fesliyanstudios.com.mp3","stream")
  collide=love.audio.newSource("Sound/mixkit-arcade-mechanical-bling-210.wav","stream")
  powerup=love.audio.newSource("Sound/mixkit-retro-arcade-casino-notification-211.wav","stream")
  death=love.audio.newSource("Sound/mixkit-arcade-retro-game-over-213.wav","stream")
  ----------------------------------------------------------
  --------------------Graphics------------------------------
  enemy_image=love.graphics.newImage("Images/ast.png")
  background_image=love.graphics.newImage("Images/try.png")
  -----------------------------------------------------------
  --------------highscore------------------------------------
  file = love.filesystem.newFile("hello2.txt")
 --load the highscore file
   if (love.filesystem.getInfo("hello2.txt"))then
     file:open("r")
     data =(file:read())
     highscore=math.floor(tonumber(data))
     file:close()
   end
   collectgarbage("stop")
   highscore = highscore or 0
end

function love.resize(w,d)
  push:resize(w,d)
end

function love.update(dt)
  xm,ym=push:toGame(love.mouse.getX(),love.mouse.getY())
  if xm~=nil and ym~=nil then
    angle = math.atan2(player.y-ym, player.x-xm) + math.pi/2+ math.pi
  else
    xm=0
    ym=0
    angle=0
  end
  if(game_start==0 and main_page==0 and game_instructions==0)then
      for k,v in pairs(all_enemy)do
        table.remove(all_enemy)
      end
    end
    -- if(gameend==1)then
    --   set=0
    --   times=0
    -- end
  if(game_start==1)then
    enemy_update(dt)
    boundary_check()
    player_movement(dt)
    bullet_update(dt)
    enemy_player_collision()
    bullet_enemy_collision()
    tclock=(clock_min*60)+clock
    file:open("w")
    file:write(highscore)
    file:close()
    file:open("r")
    data = file:read()
    highscore = math.max(tclock,highscore)
    file:close()
    if(clock_min==60)then
      gameend=1
      game_start=0
      main_page=0
      game_instructions=0
    end
  end
  love.frame = love.frame + 1
  if love.frame%100 == 0 then
    love.report = love.profiler.report(20)
    love.profiler.reset()
  end
end

function love.mousepressed(x, y, button, isTouch)
  x1,y1=push:toGame(x,y)
  if x1~=nil and y1~=nil then
    if(button==1 and game_start==1)then
      set=1
    end
    if(main_page==1)then
      if(x1>button_play.x and x1<button_play.x+button_play.width and y1>button_play.y and y1<button_play.y+button_play.height and button==1)then
        game_start=1
        main_page=0
      end
      if(x1>button_instructions.x and x1<button_instructions.x+button_instructions.width and y1>button_instructions.y and y1<button_instructions.y+button_instructions.height and button==1)then
         game_instructions=1
         main_page=0
       end
     end
     if(game_instructions==1 and x1>home_door.x and x1<((home_door.x+home_door.width)/0.25) and y1>home_door.y and y1<((home_door.y+home_door.height)/0.25) and button==1)then
       main_page=1
       game_instructions=0
     end
   end
end
function love.mousemoved(x, y, dx, dy)

--  angle = math.atan2(player.y-y,player.x-x) + math.pi/2+ math.pi
  -- body...
end
function love.mousereleased(x, y, button, isTouch)
  if(button==1 and game_start==1)then
    set=0
  end
end
----------Draw functions---------
function love.draw()
  push:start()
--  love.graphics.rectangle('fill',xm,ym,10,10)
  if(game_start==1)then
    love.graphics.setBackgroundColor(0,0,0)
    love.graphics.setColor(1,1,1)
    love.graphics.draw(background_image,0,0)
    enemy_draw()
    bullet_draw()
    HUD_draw()
    love.graphics.setColor(1,1,1)
    player_draw()
  end
  if(main_page==1 or game_instructions==1 or main_page==0 or game_start==0)then
    if(main_page==1 or game_instructions==1)then
    love.graphics.setColor(1,1,1)
    love.graphics.draw(menuback,0,0)
    love.graphics.setColor(1,1,1)
    love.graphics.draw(gametitle,240,0,nil,1.5,1.5)
    gamestate_draw()
  else
    gamestate_draw()
  end
  end
  push:finish()
end
