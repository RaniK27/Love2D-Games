bombardier_beetle =Class{__includes = interface}

function bombardier_beetle:init()
  self.width=60-------------------90,40
  self.height=30
  self.speed=150
  self.lastdirection=-1
  self.restrict_movement=true
  pl=player(self.width,self.height,self.speed,self.restrict_movement)
  self.acid_shooterx=pl.Player:getX()-self.width/2
  self.acid_shootery=pl.Player:getY()-self.height/2
  self.acid_shot=false
  self.acid_squirter={}
  self.image = love.graphics.newImage('sprites/beetle sprites.png')
  self.sheetGrid = anim8.newGrid(180,80,self.image:getWidth(),self.image:getHeight(),0, -4, 0)
  self.animation = {}
  self.animation.walk = anim8.newAnimation(self.sheetGrid('1-14', 1), 0.08)
  self.animation.jump = anim8.newAnimation(self.sheetGrid('1-14', 2), 0.08)
  self.animation.idle = anim8.newAnimation(self.sheetGrid('1-50', 3), 0.07)
  self.animation.acid = anim8.newAnimation(self.sheetGrid('1-40', 4), 0.04)
  self.currentAnimation = self.animation.idle
  self.isMoving=false
  horseflymusic:stop()
  bark_spidermusic:stop()
  bombardier_beetlemusic:play()
  butterfly_music:stop()
end

function bombardier_beetle:update(dt)
  pl:update(dt)
  if(self.acid_shot)then
    for k,v in pairs(self.acid_squirter)do
      v.timer=v.timer+dt
      if(v.timer>3)then
        v.body:destroy()
        table.remove(self.acid_squirter,k)
      end
    end
    --tt:destroy()
    if(#self.acid_squirter==0)then
      self.acid_shot=false
    end
  end


  self.acid_shooterx=pl.Player:getX()-self.lastdirection*self.width/2
  self.acid_shootery=pl.Player:getY()-self.height/2-10
  if(love.keyboard.isDown('a') or love.keyboard.isDown('left'))then
    pl.Player:applyLinearImpulse(-4,0)
    self.lastdirection=-1
    self.isMoving=true
  elseif(love.keyboard.isDown('d') or love.keyboard.isDown('right'))then
    pl.Player:applyLinearImpulse(4,0)
    self.lastdirection=1
    self.isMoving=true
  else
    self.isMoving=false
  end
  if(self.acid_shot)then
    self.currentAnimation=self.animation.acid
  elseif(pl.player_is_moving or self.isMoving)then
    self.currentAnimation=self.animation.walk
  elseif(pl.isGrounded==false)then
    self.currentAnimation=self.animation.jump
  else
    self.currentAnimation=self.animation.idle
  end
  self.currentAnimation:update(dt)
end

function bombardier_beetle:draw()
  local px, py = pl.Player:getPosition()
  self.currentAnimation:draw(self.image,px, py-17, 0, self.lastdirection * 0.6, 0.6, pl.width, pl.height/2)
  --love.graphics.rectangle("fill",self.acid_shooterx,self.acid_shootery,10,10)
  for k,v in pairs(self.acid_squirter)do
    love.graphics.setColor(1,0,0)
    love.graphics.rectangle("fill",v.body:getX(),v.body:getY(),10,10)
    love.graphics.setColor(1,1,1)
  end
end

function bombardier_beetle:special(key)
  if(key=='space' and pl.isGrounded)then
    pl.Player:applyLinearImpulse(0,-600)
  end
  if(key=='f' and pl.isGrounded)then
    acidsound:play()
    self:acid_squirt()
  end
end

function bombardier_beetle:acid_squirt()
  local projectile1={}
  local projectile2={}
  local projectile3={}
  projectile1.body=world:newRectangleCollider(self.acid_shooterx,self.acid_shootery,10,10,{collision_class='acid'})
  projectile2.body=world:newRectangleCollider(self.acid_shooterx,self.acid_shootery,10,10,{collision_class='acid'})
  projectile3.body=world:newRectangleCollider(self.acid_shooterx,self.acid_shootery,10,10,{collision_class='acid'})
  projectile1.body:applyLinearImpulse(self.lastdirection*30*2,-100*0.1/3)
  projectile2.body:applyLinearImpulse(self.lastdirection*20*2,-200*0.2/3)
  projectile3.body:applyLinearImpulse(self.lastdirection*10*2,-300*0.15/3)
  projectile1.timer=0
  projectile2.timer=0
  projectile3.timer=0
  table.insert(self.acid_squirter,projectile1)
  table.insert(self.acid_squirter,projectile2)
  table.insert(self.acid_squirter,projectile3)
  self.acid_shot=true
end
