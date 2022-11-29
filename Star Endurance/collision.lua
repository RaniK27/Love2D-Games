------------------------------collision block---
function collision(x1,y1,w1,h1,x2,y2,w2,h2)
  return x1<x2+w2 and
         x1+w1>x2 and
         y1<y2+h2 and
         y1+h1>y2
 end
 ---------------------------------------------
 --------------enemy player collision---------
 function enemy_player_collision()
   for keys,values in pairs(all_enemy)do
     if(collision(player.x-40,player.y-40,player.width,player.height,values.x,values.y,values.width,values.height))then
       if(player.health>0 and values.color==power_color[3])then
       player.health=player.health-1
       love.audio.stop(collide)
       love.audio.play(collide)
     end
     if(values.color==power_color[1])then
       love.audio.stop(powerup)
       love.audio.play(powerup)
       setP1=1
       ptimer=0
     elseif(values.color==power_color[2])then
       love.audio.stop(powerup)
       love.audio.play(powerup)
       player.health=player.maxhealth
     end
       table.remove(all_enemy,keys)
       if(player.health==0)then
         love.audio.play(death)
         game_start=0
       end
     end
   end
 end
 -----------------------------------------------
 ---------------bullet enemy collision----------
 function bullet_enemy_collision()
   for keys,values in pairs(all_bullets1)do
     for k,v in pairs(all_enemy)do
       if(collision(values.x,values.y,values.width,values.height,v.x,v.y,v.width,v.height) and v.color==power_color[3])then
         table.remove(all_enemy,k)
         table.remove(all_bullets1,keys)
       end
     end
   end
 end

---------------------------------------------------
