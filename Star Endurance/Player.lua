player={}
player_img=love.graphics.newImage('Images/player.png')
player.width=80
player.height=80
player.x=window.width/2 - player.width/2
player.y=window.height/2 - player.height/2
player.speed=600
----------------------player health bar-------
player.maxhealth=5
player.health=player.maxhealth
player.healthwidth=60
player.healthheight=20

------------------------------------------s----

function player_movement(dt)
  --xm,ym=push:toGame(love.mouse.getX(),love.mouse.getY())
  --if xm~=nil and ym~=nil then
  --  angle = math.atan2(player.y-ym, player.x-xm) + math.pi/2+ math.pi
--  else
  --  angle =0
  --end
  if(love.keyboard.isDown("w"))then
    player.y = math.max(125+player.height/2+ player.width/2,player.y - player.speed*dt)
  end
  if(love.keyboard.isDown("s"))then
    player.y = math.min(window.height-player.height/2- player.width/2,player.y + player.speed*dt)
  end
  if(love.keyboard.isDown("d"))then
    player.x = math.min(window.width - player.width/2,player.x + player.speed*dt)
  end
  if(love.keyboard.isDown("a"))then
    player.x = math.max(player.width/2,player.x - player.speed*dt)
  end
end

function boundary_check()
  if player.y < player.height then
    player.y = player.height
  elseif player.y > window.height - player.height then
    player.y = window.height - player.height
  end
  if player.x < player.height then
    player.x = player.height
  elseif player.x > window.width - player.height then
    player.x = window.width - player.height
  end
end

function player_draw()
  --love.graphics.rectangle('fill',xm,ym,10,10)
  love.graphics.draw(player_img, player.x, player.y, angle,1,1, player_img:getWidth()/2, player_img:getHeight()/2)
end
