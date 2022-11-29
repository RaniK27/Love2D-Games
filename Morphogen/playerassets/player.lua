player = Class{}

function player:init(w,h,speed,restriction)
  self.width=w
  self.height=h
  for k,v in pairs(Spawns)do
    self.resetx=v:getX()
    self.resety=v:getY()
  end
  self.Player = world:newRectangleCollider(self.resetx,self.resety,self.width,self.height,{collision_class="Player"})
  self.speed=speed
  self.Player:setFixedRotation(true)
  self.restrict=restriction
  self.isGrounded=false
  self.player_moving_up=false
  self.player_is_moving=false
  self.uptimer=0
  self.currenty=0
  -- self.resetx=300 ------------for k,v in pairs(Spawns)do self.resetx=v:getX()  self.resety=v:getY()
  -- self.resety=10

  self.grounded_timer=0
  self.lastdirection=1
  self.alpha=1
  self.death=false
  playerx=self.Player:getX()
  playery=self.Player:getY()
end

function player:update(dt)
  playerx=self.Player:getX()
  playery=self.Player:getY()
  if(self.isGrounded==false)then
    self.uptimer=self.uptimer+dt
    if(self.uptimer>0.5)then
      self.currenty=self.Player:getY()
      self.uptimer=0
    end
  end
  if(self.currenty-self.Player:getY()>0)then
    self.player_moving_up=true
  else
    self.player_moving_up=false
  end
  if self.Player.body then
    local colliders = world:queryRectangleArea(self.Player:getX()-(self.width/2)+2,self.Player:getY()+(self.height/2),self.width-6,2,{'Platform','webs'})

    if #colliders >0 then
      self.isGrounded=true
      self.grounded_timer=self.grounded_timer+dt
    else
      self.isGrounded=false
      self.grounded_timer=0
    end

    local px,py =self.Player:getPosition()
    if((love.keyboard.isDown('a') or love.keyboard.isDown('left')) and self.restrict==false)then
      self.Player:setX(px-self.speed*dt)
      self.player_is_moving=true
      self.lastdirection=-1
    elseif((love.keyboard.isDown('d') or love.keyboard.isDown('right')) and self.restrict==false)then
      self.Player:setX(px+self.speed*dt)
      self.player_is_moving=true
      self.lastdirection=1
    else
      self.player_is_moving=false
    end
  end
  -- if(self.grounded_timer>3 and self.player_is_moving==false)then
  --   self.resetx=self.Player:getX()
  --   self.resety=self.Player:getY()
  -- end
  if(self.Player:getX()<0 or self.Player:getX()>WINDOW_WIDTH or self.Player:getY()<0 or self.Player:getY()>WINDOW_HEIGHT or self.death)then
    self:reset()
    self.death=false
  end
  local collider2 = world:queryRectangleArea(self.Player:getX()-(self.width/2)-2,self.Player:getY()-(self.height/2)-2,self.width+4,self.height+4,{'bird','lizard','frog','water'})
  if(#collider2>0 or death)then
    self:reset()
    death=false
  end
  local collider3 = world:queryRectangleArea(self.Player:getX()-(self.width/2)-2,self.Player:getY()-(self.height/2)-2,self.width+4,self.height+4,{'end'})
  if(#collider3>0)then
    if(insect==4 and level=='4')then
      gotovictory=true
    end
    if(level%4==0)then
      level="0"
      nextinsect=true
    end
    nextlevel=true
  end
  -- local collider4 = world:queryRectangleArea(self.Player:getX()-(self.width/2)-2,self.Player:getY()-(self.height/2)-2,self.width+4,self.height+4,{'flower'})
  -- if(#collider4>0)then
  --   insect=insect+1
  --   level="0"
  --   nextlevel=true
  -- end
end

function player:reset()
  deathx:play()
  self.Player:setX(self.resetx)
  self.Player:setY(self.resety)
end

function player:draw()
  local px,py=self.Player:getPosition()
  ---love.graphics.print(self.currenty-self.Player:getY())
  love.graphics.rectangle("fill",px-30,py-10,60,20)
end
