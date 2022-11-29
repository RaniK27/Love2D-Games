glasswing_butterfly = Class{__includes = interface}

function glasswing_butterfly:init()
  self.speed=200
  self.width=50
  self.height=50-17
  pl=player(self.width,self.height,self.speed,false)
  pl.Player:setGravityScale(0)
  self.moving_vertical=0
  self.dy=200
  self.moving_horizontal=pl.lastdirection
  self.special_end=false
  self.special_on=false
  self.special_timer=0
  self.alpha=1
  visible=true
  self.image = love.graphics.newImage('sprites/correctedButterfly.png')
  self.sheetGrid = anim8.newGrid(200, 200, self.image:getWidth(), self.image:getHeight(), 0, 0, 0)
  self.animation = {}
  self.animation.fly = anim8.newAnimation(self.sheetGrid('1-21', 1), 0.04)
  self.animation.idle = anim8.newAnimation(self.sheetGrid('1-9', 2), 0.11)
  self.currentAnimation = self.animation.idle
  ------------------------------------------------------------------------------
  bark_spidermusic:stop()
  bombardier_beetlemusic:stop()
  butterfly_music:play()
  horseflymusic:stop()
end

function glasswing_butterfly:update(dt)
  pl:update(dt)
  local px,py=pl.Player:getPosition()
  if(self.special_on)then
    self.special_timer=self.special_timer+dt
    if(self.special_timer>3)then
      self.special_timer=0
      self.special_end=true
    end
  end
  if(love.keyboard.isDown('w') or love.keyboard.isDown('up'))then
    pl.Player:setY(py-self.dy*dt)
    self.moving_vertical=-1
  end
  if(love.keyboard.isDown('s') or love.keyboard.isDown('down'))then
    pl.Player:setY(py+self.dy*dt)
    self.moving_vertical=1
  end
  self.moving_horizontal=pl.lastdirection
  if(self.special_end)then
    self.alpha=1
  end


  self.currentAnimation:update(dt)
  if pl.player_is_moving or pl.player_moving_up then
    self.currentAnimation = self.animation.fly
  else
    self.currentAnimation = self.animation.idle
  end
end

function glasswing_butterfly:special(key)

  if((key=='f' and self.alpha==0.8) or self.special_end)then
    butterfly_special:play()
    self.alpha=1
    visible=true
    self.special_end=false
  elseif(key=='f')then
    self.alpha=0.3
    visible=false
    self.special_on=true
  end
end

function glasswing_butterfly:draw()
  love.graphics.setColor(1,1,1,self.alpha)
  local px, py = pl.Player:getPosition()
  self.currentAnimation:draw(self.image, px, py-10, 0, pl.lastdirection * 80/200, 1 * 80/200, 2 * pl.width, 2 * pl.height)
  love.graphics.setColor(1,1,1)
end
