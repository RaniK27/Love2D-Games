lizard = Class{}

function lizard:init(x,y)
  self.width=70
  self.height=30
  self.x=x
  self.y=y
  self.collider=world:newRectangleCollider(self.x,self.y,self.width,self.height,{collision_class='lizard'})
  self.collider:setFixedRotation(true)
  self.speed=80
  self.direction=1
  self.dead=false
  self.image = love.graphics.newImage('sprites/spritesheetLizard.png')
  self.sheetGrid = anim8.newGrid(140, 60, self.image:getWidth(), self.image:getHeight(), 0, 0, 0)
  self.animations = {}
  self.animations.crawl = anim8.newAnimation(self.sheetGrid('1-30',1), 0.02)
  self.currentAnimation = self.animations.crawl
end

function lizard:update(dt)

  local collider=world:queryRectangleArea(self.collider:getX()-(self.width/3),self.collider:getY()+(self.height/3),20,20,{"Platform"})
  local collider2=world:queryRectangleArea(self.collider:getX()+(self.width/3)-10,self.collider:getY()+(self.height/3),20,20,{"Platform"})
  local collider3=world:queryRectangleArea(self.collider:getX()-(self.width/2)-20,self.collider:getY(),20,10,{"Platform","walls"})
  local collider4=world:queryRectangleArea(self.collider:getX()+(self.width/2),self.collider:getY(),20,10,{"Platform","walls"})
  local collider5=world:queryRectangleArea(self.collider:getX()-(self.width/2)-4,self.collider:getY()-(self.height/2)-4,self.width+8,self.height+8,{"acid"})
  if(#collider3>0)then
    self.direction=1
  elseif(#collider4>0)then
    self.direction=-1
  elseif(#collider==0)then
    self.direction=1
  elseif(#collider2==0)then
    self.direction=-1
  end
  local px,py=self.collider:getPosition()
  self.collider:setX(self.collider:getX()+self.speed*dt*self.direction,0)
  if(#collider5>0)then
    self.dead=true
  end
  self.currentAnimation:update(dt)
end

function lizard:draw()
  self.currentAnimation:draw(self.image,self.collider:getX(),self.collider:getY(), 0, 1*self.direction,1.25, self.width+20, self.height+2)
end
