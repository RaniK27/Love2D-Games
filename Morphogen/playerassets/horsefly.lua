horsefly = Class{__includes = interface}

function horsefly:init()
  pl=player(40,40,150,false)
  pl.Player:setGravityScale(0)
  self.dy=150
  self.moving_vertical=0
  self.moving_horizontal=pl.lastdirection
  self.special_timer=0
  self.special_end=false
  self.special_on=false
  self.alpha=1
  self.image = love.graphics.newImage('sprites/Flyspritesheet.png')
  self.sheetGrid = anim8.newGrid(120, 90, self.image:getWidth(), self.image:getHeight(), 0, 0, 0)
  self.animation = {}
  self.animation.idle = anim8.newAnimation(self.sheetGrid('1-29', 1), 0.03)
  self.animation.fly = anim8.newAnimation(self.sheetGrid('1-10', 2), 0.1)
  self.currentAnimation = self.animation.idle
  ------------------------------------------------------------------------------music
  bark_spidermusic:stop()
  bombardier_beetlemusic:stop()
  butterfly_music:stop()
  horseflymusic:play()

end

function horsefly:update(dt)
  pl:update(dt)
  if(self.special_on)then
    self.special_timer=self.special_timer+dt
    if(self.special_timer>3)then
      self.special_end=true
    end
  end
  self.moving_horizontal=pl.lastdirection
  local px,py=pl.Player:getPosition()
  if(love.keyboard.isDown('w') or love.keyboard.isDown('up'))then
    pl.Player:setY(py-self.dy*dt)
    self.moving_vertical=-1
  end
  if(love.keyboard.isDown('s') or love.keyboard.isDown('down'))then
    pl.Player:setY(py+self.dy*dt)
    self.moving_vertical=1
  end
  if(self.special_end)then
    self.dy=300
    pl.speed=300
  end
--------------------------------------------------------------------------------
  self.currentAnimation:update(dt)
  if pl.player_is_moving or pl.player_moving_up then
    self.currentAnimation = self.animation.fly
  else
    self.currentAnimation = self.animation.idle
  end
end

function horsefly:draw()
-- pl:draw()
local px, py = pl.Player:getPosition()
self.currentAnimation:draw(self.image, px, py, 0, pl.lastdirection * 60/120, 1 * 50/90, pl.width,pl.player_is_moving==true and pl.height+10 or  pl.height-20)
end

function horsefly:special(key)
  if((self.dy==1000 and key=='f') or self.special_end)then
    self.dy=150
    pl.speed=150
    self.special_end=false
    self.special_timer=0
    self.special_on=false
  elseif(key=='f')then
    fly_special:play()
    self.dy=1000
    pl.speed=1000
    self.special_on=true
  end
end
