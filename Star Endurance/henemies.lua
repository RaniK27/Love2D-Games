------------------------------------------------
---------------color code-----------------------
power_color={{1,0,0},{0,1,0},{1,1,1}}
--------------------------------------------------
---------Main code--------------------------------

--------------Create enemy-----------
function create_enemy()
  enemy={}
  enemy.width=player.width/1.5
  enemy.height=player.height/1.5
  flag3=math.random(0,100)
  if(flag3>95)then
    enemy.width=player.width/2.5
    enemy.height=player.height/2.5
    enemy.color=power_color[1]
  elseif(flag3>85 and flag3<95)then
    enemy.width=player.width/2.5
    enemy.height=player.height/2.5
    enemy.color=power_color[2]
  else
    enemy.color=power_color[3]
  end
  flag1=math.random(0,100)
  if(flag1<50)then
  enemy.y= math.random(-100,0)
  enemy.dy= math.random(0,1000)
  else
  enemy.y=math.random(window.height,window.height+100)
  enemy.dy= -math.random(0,1000)
end
flag2=math.random(200,300)
if(flag2<250)then
enemy.x= math.random(-100,0)
enemy.dx=math.random(0,1000)
else
enemy.x=math.random(window.width,window.width+100)
enemy.dx=-math.random(0,1000)
end
 return enemy
end
all_enemy={}
----------------------------------------
function enemy_update(dt)
  -------------Enemy creation---------
rand=math.random(-200,1000)
  if (rand>985)then
    table.insert(all_enemy,create_enemy())
  end
  for keys,values in pairs(all_enemy)do
    if(values.x<-100 or values.x>window.width+100 or values.y<-100 or values.y>window.height+100)then
      table.remove(all_enemy,keys)------delete condition------------
    end
    values.dx=(player.x-values.x)/1
    values.dy=(player.y-values.y)/1
    values.y=values.y+(values.dy*dt)
    values.x=values.x+(values.dx*dt)
  end
end
function enemy_draw()
  for keys,values in pairs(all_enemy)do
    love.graphics.setColor(values.color[1],values.color[2],values.color[3])
    love.graphics.rectangle("fill", values.x, values.y, values.width, values.height)
end
love.graphics.print(#all_enemy, 500, 500)
end
