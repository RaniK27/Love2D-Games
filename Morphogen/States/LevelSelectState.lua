LevelSelectState = Class{__includes = BaseState}

function LevelSelectState:init()
  insect = 1
  level = "1"
  for k,v in pairs(enemies)do
    table.remove(enemies,k)
  end
  destroyAll()
  self.ww = 800
  self.wh = 800
  self.mouse_x=0
  self.level=1
  self.mouse_y=0

  self.counter=1
  bark_spidermusic:stop()
  bombardier_beetlemusic:stop()
  horseflymusic:stop()
------------------------------assests------------------------------------------------
Bug1=love.graphics.newImage("States/levelSelectUI/bug1silhouette.png")
Bug2=love.graphics.newImage("States/levelSelectUI/bug2silhouette.png")
Bug3=love.graphics.newImage("States/levelSelectUI/bug3silhouette.png")
Bug4=love.graphics.newImage("States/levelSelectUI/bug4silhouette.png")
BackGround = love.graphics.newImage("States/levelSelectUI/level select.png")
Bwidth=Bug1:getWidth( )*0.4
Bheigth=Bug1:getHeight( )*0.4
--------------------------------------------------------------------------------------
  self.Many_levels_coordinates1={}
  self.Many_levels_coordinates2={}
  self.Many_levels_coordinates={}
table.insert(self.Many_levels_coordinates,self.Many_levels_coordinates1)
table.insert(self.Many_levels_coordinates,self.Many_levels_coordinates2)
  for i=0,1 do
    table.insert(self.Many_levels_coordinates1,{Bug={Bug1,Bug2},
                                              x=300+500*i-100,y=300,width=Bwidth,height=Bheigth,collide=false})
  end
  for i=0,1 do
    table.insert(self.Many_levels_coordinates2,{Bug = {Bug3,Bug4},
                                              x=400+250*i-100,y=500,width=Bwidth,height=Bheigth,collide=false})
  end


end

function LevelSelectState:update()
  self.mouse_x,self.mouse_y=push:toGame(love.mouse.getX(),love.mouse.getY())

for keys,values in pairs(self.Many_levels_coordinates) do
for keys,values in pairs(self.Many_levels_coordinates[keys]) do
    if self.mouse_x~=nil and self.mouse_y~=nil then
      if Rect_coll(values,self.mouse_x,self.mouse_y) then
         values.collide=true
      else
        values.collide=false
      end
    end
  end
end
end

function LevelSelectState:mouse_pressed(x,y)
  for keys,values in pairs(self.Many_levels_coordinates) do
    for keys,values in pairs(self.Many_levels_coordinates[keys]) do
  -- if x~=nil and y~=nil then
    if Rect_coll(values,x,y) then
      -- if(values.l<=#level_obj)then
      --    self.level=keys
      --    current_level=values.l
         -- Level_initializer(level_obj[values.l]())
         if(x>200 and y>300 and x<200+(Bug1:getWidth( )*0.4) and y<300+(Bug1:getHeight( )*0.4))then
           insect=2
           level="1"
         end
         if(x>700 and y>300 and x<700+(Bug1:getWidth( )*0.4) and y<300+(Bug1:getHeight( )*0.4))then
           insect=4
           level="1"
         end
         if(x>300 and y>500 and x<300+(Bug1:getWidth( )*0.4) and y<500+(Bug1:getHeight( )*0.4))then
           insect=3
           level="1"
         end
         if(x>550 and y>500 and x<550+(Bug1:getWidth( )*0.4) and y<500+(Bug1:getHeight( )*0.4))then
           insect=1
           level="1"
         end
         gStateMachine:change('play')
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

-----------------------------render function-----------------------------------------------------------
function LevelSelectState:render()
love.graphics.draw(BackGround, 0, 0)

  for keys,values in pairs(self.Many_levels_coordinates) do
    for keys,values in pairs(self.Many_levels_coordinates[keys]) do
    if values.collide == true then
      love.graphics.setColor(0,1,0)
      love.graphics.draw(values.Bug[keys],values.x,values.y,0,0.4,0.4)
      -- love.graphics.draw(drawable, x, y, r, sx, sy, ox, oy, kx, ky)
    else
      love.graphics.setColor(1,1,1)
    end
    love.graphics.draw(values.Bug[keys],values.x,values.y,0,0.4,0.4)
  end
end


end
