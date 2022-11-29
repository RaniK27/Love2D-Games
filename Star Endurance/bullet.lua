setP1=0
setP2=0
count=1
ang1=0
ang2=0
timer=0
clock=0
tclock=0
clock_min=0
set=0
times=0
ptimer=0
----------------------------------------------
----------------------bullet config-----------
function create_bullet()
  bullet={}
  bullet.width=10
  bullet.height=10
  bullet.x=player.x-bullet.width/2
  bullet.y=player.y-bullet.height/2
  bullet.xspeed=1000
  bullet.yspeed=1000
  bullet.angle= math.pi-angle
  ang1=bullet.angle+math.pi*(3/4)
  ang2=bullet.angle-math.pi*(3/4)
  bullet.color={1,1,1}
  if(setP1==1)then
    bullet.color={1,0,0}
    if(count==1)then
      bullet.angle=bullet.angle
      count=2
    elseif(count==2)then
      bullet.angle=ang1
      count=3
    elseif(count==3)then
      bullet.angle=ang2
      count=1
    end
  end
  return bullet
end
all_bullets1={}
------------------------------------------------
---------------------update function------------
function bullet_update(dt)
  for keys,values in pairs(all_bullets1)do

    values.x=values.x+values.xspeed*math.sin(values.angle)*dt
    values.y=values.y+values.yspeed*math.cos(values.angle)*dt
    if(values.x>window.width or values.x<0 or values.y>window.height or values.y<0)then
      table.remove(all_bullets1,keys)
    end
  end
  ptimer=ptimer+dt
  if(setP1==1)then
    if(ptimer>5)then
      setP1=0
      ptimer=0
    end
  end
  if(set==0)then
  love.audio.stop(shootpowerup)
  end
  if(set==1 and times>0.15)then
    table.insert(all_bullets1,create_bullet())
    if(setP1==0)then
      love.audio.stop(shoot)
      love.audio.play(shoot)
    end
    if(setP1==1)then
      love.audio.play(shootpowerup)
      table.insert(all_bullets1,create_bullet())
      table.insert(all_bullets1,create_bullet())
    end
    times=0
  end
    times=times+dt
  angle=angle+0.3*dt
  ang1=angle+math.pi/2+math.pi/4
  ang2=angle-math.pi/2-math.pi/4
  timer=timer+dt
  if(timer>1)then
    clock=clock+1
    timer=0
    if(clock>59)then
      clock_min=clock_min+1
      clock=0
    end
  end
end
------------------------------------------------
-------------------------------------------------
--------------------bullet draw function---------
function bullet_draw()
if(set==1 or set==0)then
  for keys,values in pairs(all_bullets1)do
    love.graphics.setColor(values.color[1],values.color[2],values.color[3])
    love.graphics.rectangle("fill",values.x,values.y,values.width,values.height)
  end
 end
end
-------------------------------------------------
