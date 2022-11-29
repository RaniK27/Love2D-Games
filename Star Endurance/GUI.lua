--------------------game states----------------
main_page=1
game_start=0
game_instructions=0
-----------------------------------------------
-----------------buttons config----------------
button_play={}
button_instructions={}
button_play.width=400
button_play.height=75
button_play.x=window.width/2-button_play.width/2
button_play.y=window.height/2-75
button_instructions.width=400
button_instructions.height=75
button_instructions.x=window.width/2-button_play.width/2
button_instructions.y=window.height/2+75
-----------------------------------------------

----------------function to return to main or restart-----
function love.keypressed(key)
  if(gameend==1 and game_start==0 and main_page==0 and game_instructions==0)then
    if(key=='m')then
      main_page=1
      game_start=0
      game_instructions=0
      player.health=player.maxhealth
      timer=0
      clock=0
      gameend=0
      clock_min=0
    end
  end
  if(game_start==0 and main_page==0 and game_instructions==0)then
    if(key=='m')then
      main_page=1
      game_start=0
      game_instructions=0
      player.health=player.maxhealth
      timer=0
      clock=0
      clock_min=0
    end
    if(key=='r')then
      player.health=player.maxhealth
      game_start=1
      timer=0
      clock=0
      clock_min=0
    end
  end
  if key=="escape"then
    love.event.quit()
  end
end

-----------------draw--------------------------
function gamestate_draw()
  love.graphics.setNewFont('Fonts/AtariClassicExtrasmooth-LxZy.ttf',20)
  if( main_page==1 and game_start==0 and game_instructions==0)then
    if(collision(button_play.x,button_play.y,button_play.width,button_play.height,xm,ym,1,1))then
     love.graphics.setColor(1,0,0)
     love.graphics.rectangle("fill",button_play.x,button_play.y,button_play.width,button_play.height,20)
   else
     love.graphics.setColor(0,0,0)
     love.graphics.rectangle("fill",button_play.x,button_play.y,button_play.width,button_play.height,20)
     love.graphics.setColor(1,0,0)
     love.graphics.rectangle("line",button_play.x,button_play.y,button_play.width,button_play.height,20)
   end
     if(collision(button_instructions.x,button_instructions.y,button_instructions.width,button_instructions.height,xm,ym,1,1))then
     love.graphics.setColor(1,0,0)
     love.graphics.rectangle("fill",button_instructions.x,button_instructions.y,button_instructions.width,button_instructions.height,20)
   else
     love.graphics.setColor(0,0,0)
     love.graphics.rectangle("fill",button_instructions.x,button_instructions.y,button_instructions.width,button_instructions.height,20)
     love.graphics.setColor(1,0,0)
     love.graphics.rectangle("line",button_instructions.x,button_instructions.y,button_instructions.width,button_instructions.height,20)
   end
     love.graphics.setColor(1,1,1)
     love.graphics.print("Play",button_play.x+button_play.width/2-30,button_play.y+button_play.height/2-10)
     love.graphics.print("Instructions",button_instructions.x+button_instructions.width/2-120,button_instructions.y+button_instructions.height/2-10)
  end
  if(game_instructions==1)then
    love.graphics.setNewFont('AtariClassicExtrasmooth-LxZy.ttf',25)
    love.graphics.setColor(1,0,0)
    love.graphics.printf("\nInstructions:\n\n \n\nUse W,A,S,D for movement\n \n\nUse mouse to rotate\n \n\nLeft click to fire\n \n\nGreen colour powerups replenish health\n \n\nRed colour powerups shoots a barrage of bullets while red square next to green health bar is active  ",window.width/9,window.height/4,window.width*(4/5),'center')
    love.graphics.draw(home_door.image,home_door.x,home_door.y,nil,0.25,0.25)
  end
  if(game_start==0 and main_page==0 and game_instructions==0 and gameend==0)then
    love.graphics.setColor(1,0,0)
    love.graphics.print("Press R to restart or press M to go to main menu",window.width/2-475,window.height/2-40)
    set=0
    times=0
  end
  if(gameend==1 and game_start==0 and main_page==0 and game_instructions==0)then
    love.graphics.setColor(1,0,0)
    love.graphics.print("Congratulations!! You have officially beaten the game.",window.width/2-550,window.height/2-40)
    love.graphics.print("Press M to go to main menu",window.width/2-550,window.height/2+40)
  end
end
-----------------------------------------------
