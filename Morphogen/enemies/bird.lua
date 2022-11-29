bird = Class{}

function bird:init(x,y)
  self.width=30
  self.height=30
  self.x=x
  self.y=y
  self.collider=world:newRectangleCollider(self.x,self.y,self.width,self.height,{collision_class='bird'})
  self.collider:setGravityScale(0)
  self.collider:setFixedRotation(true)
  self.speed=100
  self.deltax=0
  self.deltay=0
  self.detection_radius=250
  self.angle=0
  self.detection=0
  self.dead=false
  self.image = love.graphics.newImage('sprites/bird.png')
  self.sheetGrid = anim8.newGrid(60, 60, self.image:getWidth(), self.image:getHeight(), 0, 0, 0)
  self.animation = {}
  self.animation.bird = anim8.newAnimation(self.sheetGrid('1-26', 1), 0.03)
end

function bird:update(dt)
  self.deltax=playerx-self.collider:getX()
  self.deltay=playery-self.collider:getY()
  self.detection=math.sqrt((self.deltax*self.deltax)+(self.deltay*self.deltay))
  if(self.detection < self.detection_radius and visible)then
    self.angle=math.atan2(self.deltay,self.deltax)
    self.collider:setX(self.collider:getX()+self.speed*dt*math.cos(self.angle))
    self.collider:setY(self.collider:getY()+self.speed*dt*math.sin(self.angle))
  else
    self.angle=math.atan2(self.y-self.collider:getY(),self.x-self.collider:getX())
    self.collider:setX(self.collider:getX()+self.speed*dt*math.cos(self.angle))
    self.collider:setY(self.collider:getY()+self.speed*dt*math.sin(self.angle))
  end
  local collider=world:queryRectangleArea(self.collider:getX()-27,self.collider:getY()-27,54,54,{'acid'})
  if(#collider>0)then
    self.dead=true
  end
  self.animation.bird:update(dt)
end

function bird:draw()
  self.animation.bird:draw(self.image, self.collider:getX(), self.collider:getY(), 0, self.deltax/math.abs(self.deltax)*2, 2, self.width, self.height)
end
