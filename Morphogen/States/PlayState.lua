PlayState = Class{__includes = BaseState}


enemies={}
function PlayState:init()
  for k,v in pairs(enemies)do
    --if v.tt:isDestroyed() == false then
     -- v.tt:destroy()
    --end
    table.remove(enemies,k)
  end
  destroyAll()
  storeLvl = {}
  storeLvl.currentLevel = insect_level[insect].."/level"..level
  if love.filesystem.getInfo("data.lua") then
  local data = love.filesystem.load("data.lua")
  data()
  end
  map_spawn(storeLvl.currentLevel)
  self.pause=false
-- function loadMap(mapName)
-- storeLvl.currentLevel = mapName
-- love.filesystem.write("data.lua", table.show(storeLvl, "storeLvl"))
end

function PlayState:enter()

  insects={horsefly,bombardier_beetle,glasswing_butterfly,bark_spider}
  bs=insects[insect]()
end

function PlayState:update(dt)
  if(self.pause==false)then
    gameMap:update(dt)
    world:update(dt)
    bs:update(dt)
    for k,v in pairs(enemies)do
      v:update(dt)
      if(v.dead)then
        v.collider:destroy()
        table.remove(enemies,k)
      end
    end

    local px,py=pl.Player:getPosition()
    if(nextlevel)then
      for k,v in pairs(enemies)do
        v.collider:destroy()
       -- tt.destroy()
        table.remove(enemies,k)
      end

      if(#enemies==0)then
        if(nextinsect and gotovictory==false)then
          insect=insect+1
          nextinsect=false
        end
        local a=level+1
        level=tostring(a)
        nextlevel=false
        gStateMachine:change('play')
      end
    end
  end
  --cam:lookAt()
  if(gotovictory)then
    gotovictory=false
    gStateMachine:change('victory')
  end
end

function PlayState:render()
  --cam:attach()
    gameMap:drawLayer(gameMap.layers["Background"])
    gameMap:drawLayer(gameMap.layers["Tile Layer 1"])
  --world:draw()
  bs:draw()
  for k,v in pairs(enemies)do
    v:draw()
  end
  --love.graphics.print(#enemies)-------------------------------------------------------------------pause
  if(self.pause)then
    love.graphics.setColor(0,0,0,1)
    love.graphics.setLineWidth(3)
    love.graphics.rectangle('fill',WINDOW_WIDTH/2-200,WINDOW_HEIGHT/2-200,400,500,12)
    love.graphics.setColor(0.13,0.54,0.13,0.8)
    love.graphics.rectangle('line',WINDOW_WIDTH/2-100,WINDOW_HEIGHT/2-100,200,50,12)
    love.graphics.printf("Resume",WINDOW_WIDTH/2-100,WINDOW_HEIGHT/2-100,200,"center")
    love.graphics.rectangle('line',WINDOW_WIDTH/2-100,WINDOW_HEIGHT/2,200,100,12)
    love.graphics.printf("Main Menu",WINDOW_WIDTH/2-100,WINDOW_HEIGHT/2,200,"center")
    love.graphics.rectangle('line',WINDOW_WIDTH/2-100,WINDOW_HEIGHT/2+150,200,100,12)
    love.graphics.printf("Level Select",WINDOW_WIDTH/2-100,WINDOW_HEIGHT/2+150,200,"center")
  end
  --cam:detach()
end
--------------------------------------------------------------------------------
function PlayState:key_released(key)

end
--------------------------------------------------------------------------------

function PlayState:mouse_pressed(x,y)
  if(x>WINDOW_WIDTH/2-100 and x<WINDOW_WIDTH/2-100+200 and y>WINDOW_HEIGHT/2-100 and y<WINDOW_HEIGHT/2-100+50)then
    self.pause=false
  end
  if(x>WINDOW_WIDTH/2-100 and x<WINDOW_WIDTH/2-100+200 and y>WINDOW_HEIGHT/2 and y<WINDOW_HEIGHT/2+100)then

    gStateMachine:change('title')
  end
  if(x>WINDOW_WIDTH/2-100 and x<WINDOW_WIDTH/2-100+200 and y>WINDOW_HEIGHT/2+150 and y<WINDOW_HEIGHT/2+150+100)then

    gStateMachine:change('level select')
  end
end

function PlayState:key_pressed(key)
  bs:special(key)
  if(key=='escape' and self.pause==true)then
    self.pause=false
  elseif(key=='escape')then
    self.pause=true
  end
end

function PlayState:exit()
  bark_spidermusic:stop()
  bombardier_beetlemusic:stop()
  butterfly_music:stop()
  horseflymusic:stop()
  for k,v in pairs(enemies)do
    table.remove(enemies,k)
  end
  destroyAll()
end
