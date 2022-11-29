bark_spider=Class{__includes = interface}
yi=0
function bark_spider:init()
  self.jump_height=550
  pl=player(60,20,240,false)
  self.projectile_speed=1000
  self.pro_l_recordx=0
  self.pro_r_recordx=0
  self.pro_l_recordy=0
  self.pro_r_recordy=0
  self.projectile_firedl=false
  self.projectile_firedr=false
  self.playerfiringposition=0
  self.all_webs={}
  self.webtimer={}
  self.webl=false
  self.webr=false
  self.image = love.graphics.newImage('sprites/CombinedSpriteSheet.png')
  self.sheetGrid = anim8.newGrid(200, 100, self.image:getWidth(), self.image:getHeight(), 0, 0, 0)
  --self.webImage = love.graphics.newImage('sprites/web.png')
  self.animations = {}
  self.animations.crawl = anim8.newAnimation(self.sheetGrid('1-24', 6), 0.02)
  self.animations.idle = anim8.newAnimation(self.sheetGrid('1-37', 1), 0.025)
  self.animations.shoot = anim8.newAnimation(self.sheetGrid('1-11', 9), 0.06)
  self.animations.jump = anim8.newAnimation(self.sheetGrid('1-30',4),0.08)
  self.currentAnimation = self.animations.idle
  self.webImage=love.graphics.newImage('sprites/web.png')
  ------------------------------------------------------------------------------music
  horseflymusic:stop()
  bombardier_beetlemusic:stop()
  bark_spidermusic:play()
  butterfly_music:stop()
end

function bark_spider:special(key)
  ------------------------------------------------------------------------------spiders jump ability
  if(key=="space" and pl.isGrounded==true)then
    pl.Player:applyLinearImpulse(0,-self.jump_height)
  end
  ------------------------------------------------------------------------------spiders platform creator ability
  if(key=='f' and  #self.all_webs<2 and pl.isGrounded==false and pl.player_moving_up==true)then
    spider_special:play()
    self:webprojectiles()
    self.currentAnimation = self.animations.shoot
  end
end


function bark_spider:update(dt)
  pl:update(dt)
  if(#self.all_webs~=0)then
    for k,v in pairs(self.all_webs)do
      v.timer=v.timer+dt
      if(v.timer>5)then
        v.temp_resting_web:destroy()
        table.remove(self.all_webs,k)
      end
    end
  end

  if (self.projectile_firedl) then
    local prx,pry= self.projectilel:getPosition()
    local colliderare=world:queryRectangleArea(prx-23,pry-2,20,8,{'walls','frog','Platform'})

    if #colliderare>0 then
      self.pro_l_recordx=prx
      self.pro_l_recordy=pry+2
      self.projectile_firedl=false
      if(self.projectilel~=nil)then
        self.projectilel:destroy()
      end
      self.webl=true
    end
    if self.playerfiringposition-prx>700 then
      self.projectile_firedl=false
      if(self.projectilel~=nil)then
        self.projectilel:destroy()
      end
    end
  end
  if (self.projectile_firedr) then
    local prx,pry= self.projectiler:getPosition()
    local colliderarea=world:queryRectangleArea(prx+3,pry-2,20,8,{'walls','frog','Platform'})
    if #colliderarea>0 then
      self.pro_r_recordx=prx
      self.pro_r_recordy=pry+2
      if(self.projectiler~=nil)then
        self.projectile_firedr=false
      end
      self.projectiler:destroy()
      self.webr=true
    end
    if prx-self.playerfiringposition>700 then
      self.projectile_firedr=false
      if(self.projectiler~=nil)then
        self.projectiler:destroy()
      end
    end
  end
  if(math.abs(self.pro_l_recordy-pl.Player:getY())<15)then
    self.webl=false
    self.webr=false
  end
  if(self.webl==true and self.webr==true)then
    self:deploy_web()
    self.webl=false
    self.webr=false
  end

  ------------------------------------------------------------------------------
  if pl.isGrounded==false  and self.currentAnimation~=self.animations.shoot then
    self.currentAnimation = self.animations.jump
  elseif pl.player_is_moving and pl.isGrounded then
    self.currentAnimation = self.animations.crawl
  elseif pl.isGrounded then
    self.currentAnimation = self.animations.idle
  end
  self.currentAnimation:update(dt)
end

function bark_spider:draw()
  local px, py = pl.Player:getPosition()
  self.currentAnimation:draw(self.image, pl.lastdirection==1 and px-20 or px+20, py-15, 0, pl.lastdirection * 0.5, 0.5, pl.width, pl.height)
  for k,v in pairs(self.all_webs)do
    love.graphics.draw(self.webImage,v.temp_resting_web:getX()-(self.pro_r_recordx-self.pro_l_recordx)/2,v.temp_resting_web:getY()-10,0,(self.pro_r_recordx-self.pro_l_recordx)/self.webImage:getWidth(),1)
  end
  if (self.projectile_firedl and self.projectilel~=nil) then
    love.graphics.rectangle('fill',self.projectilel:getX(),self.projectilel:getY()-4,10,10)
  end
  if (self.projectile_firedr and self.projectiler~=nil) then
    love.graphics.rectangle('fill',self.projectiler:getX(),self.projectiler:getY()-4,10,10)
  end
end

function bark_spider:webprojectiles()
  local px,py=pl.Player:getPosition()
  self.projectilel=world:newRectangleCollider(px-pl.width/2-4,py+pl.height/2+2,4,8,{collision_class='shootable'})
  self.projectiler=world:newRectangleCollider(px+pl.width/2,py+pl.height/2+2,4,8,{collision_class='shootable'})
  self.projectilel:applyLinearImpulse(-self.projectile_speed,0)
  self.projectiler:applyLinearImpulse(self.projectile_speed,0)
  self.projectile_firedl=true
  self.projectile_firedr=true
  self.playerfiringposition=px
end

function bark_spider:deploy_web()
  ta={}
  ta.temp_resting_web=world:newRectangleCollider(self.pro_l_recordx,self.pro_l_recordy+2,self.pro_r_recordx-self.pro_l_recordx,20,{collision_class='webs'})
  ta.temp_resting_web:setType('static')
  ta.timer=0
  table.insert(self.all_webs,ta)
end
