TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:init()
  for k,v in pairs(enemies)do
    table.remove(enemies,k)
  end
  destroyAll()
  for _, body in pairs(world:getBodies()) do
        body:destroy()
  end
  self.ww = love.graphics.getWidth()
  self.wh = love.graphics.getHeight()
  self.mouse_x=0
  self.mouse_y=0
  Background_image=love.graphics.newImage("States/main_menu.png")
  Play_button = love.graphics.newImage("States/StartButton.png")
  Level_select = love.graphics.newImage("States/LevelButton.png")
  Instruction = love.graphics.newImage("States/InstructionsButton.png")
  EXIT=love.graphics.newImage("States/ExitButton.png")
  width_S=EXIT:getWidth( )*0.5
  heigth_S=EXIT:getHeight( )*0.5

  self.Menu_selection={}
  for i=0,3 do
    table.insert(self.Menu_selection,{name={Play_button,Level_select,Instruction,EXIT},
                x=WINDOW_WIDTH/2-500,y=100+100*i,
                width=width_S,height=heigth_S,collide=false})
  end
  -- bark_spidermusic:play()
  -- bark_spidermusic:stop()
  -- bombardier_beetlemusic:play()
  -- bombardier_beetlemusic:stop()
  --   horseflymusic:play()
  -- horseflymusic:stop()

end


function TitleScreenState:update(dt)

  self.mouse_x,self.mouse_y=push:toGame(love.mouse.getX(),love.mouse.getY())

  for keys,values in pairs(self.Menu_selection) do
    if self.mouse_x~=nil and self.mouse_y~=nil then
      if Rect_coll(values,self.mouse_x,self.mouse_y) then
         values.collide=true
      else
         values.collide=false
      end
    end
  end
end


function TitleScreenState:mouse_pressed(x,y)

  for keys,values in pairs(self.Menu_selection) do
    if Rect_coll(values,x,y) then
      if keys == 1 then
        -- current_level=current_level<level_max and current_level+1 or level_max
        -- Level_initializer(level_obj[current_level]())
        gStateMachine:change('story')
      elseif keys == 2 then
        gStateMachine:change('level select')

      elseif keys == 3 then
        gStateMachine:change('instruction')

      elseif keys == 4 then
        love.event.quit()

      end
    end
  end
end


function Rect_coll(values,x,y)
  return x<values.x+values.width and
        x+tonumber(2)>values.x and
        y<values.y+values.height and
        y+tonumber(2)>values.y
  end

---------------------------------------Render function----------------------------

function TitleScreenState:render()
love.graphics.draw(Background_image, 0, 0)
  for keys,values in pairs(self.Menu_selection) do
    if values.collide == true then
      love.graphics.setColor(1,0.9,0)
      love.graphics.draw(values.name[keys],values.x,values.y,0,0.5,0.5)
      love.graphics.setColor(0,1,0)
    else
      love.graphics.setColor(0,1,0)
      love.graphics.draw(values.name[keys],values.x,values.y,0,0.5,0.5)
    end
  end
    love.graphics.setColor(1,1,1)
end
