StoryState = Class{__includes = BaseState}

function StoryState:init()
  insect = 1
  level = "1"
  for k,v in pairs(enemies)do
    table.remove(enemies,k)
  end
  destroyAll()
  self.dialogue="1"
  self.image=love.graphics.newImage("Scene_1_Dialogues/dlg"..self.dialogue..".png")
end

function StoryState:render()
  love.graphics.draw(self.image,0,0,0,WINDOW_WIDTH/self.image:getWidth(),WINDOW_HEIGHT/self.image:getHeight())
end

function StoryState:update()
  self.image=love.graphics.newImage("Scene_1_Dialogues/dlg"..self.dialogue..".png")
end

function StoryState:mouse_pressed(x,y)
  if(self.dialogue=="18")then
    insect=1
    level="1"
    gStateMachine:change('play')
  else
    local a=self.dialogue+1
    self.dialogue=tostring(a)
  end
  bark_spidermusic:stop()
  bombardier_beetlemusic:stop()
  horseflymusic:stop()
end

function StoryState:key_pressed(key)
  if(self.dialogue=="19")then
    gStateMachine:change('play')
  else
    local a=self.dialogue+1
    self.dialogue=tostring(a)
  end
end
