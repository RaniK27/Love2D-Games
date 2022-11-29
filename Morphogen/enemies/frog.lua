frog =Class{}

function frog:init(x,y)
  self.frogx=x
  self.frogy=y
  self.frogWidth=30
  self.frogHeight=30
  self.collider=world:newRectangleCollider(self.frogx,self.frogy,self.frogWidth,self.frogHeight,{collision_class='frog'})
  self.collider:setType('static')
  self.tonguex=self.frogx+self.frogWidth/2-10
  self.tonguey=self.frogy+10-30
  self.tonguewidth=20
  self.tongueheight=40
  self.tonguespeed=100
  self.playerreset=false
  self.webbed=false
  self.dead=false
  self.image = love.graphics.newImage('sprites/frog.png')
  self.tongueimage=love.graphics.newImage('sprites/frogtongue.png')

  self.tonguedirection = 1
 -- self.tt=world:newRectangleCollider(self.tonguex,self.tonguey,self.tonguewidth,self.tongueheight,{collision_class='tongue'})
 -- self.tt:setType('static')
  --self.tt:setX(self.tonguex+10)
  --self.tt:setY(self.tonguey)
 -- table.insert(tongue,self.tt)
end

function frog:update(dt)
  if(self.webbed==false)then
    local collider=world:queryRectangleArea(self.tonguex,self.tonguey,self.tonguewidth,self.tongueheight,{'Player'})
    if(#collider>0)then
      self.playerreset=true
      death=true
    end

    self.tonguey=self.tonguey-self.tonguespeed*dt*self.tonguedirection
    --self.tt:setY(self.tt:getY()-self.tonguespeed*dt )


    if(self.tonguey<self.frogy-60)then
      self.tonguedirection = -1
      -- self.tonguespeed=self.tonguespeed*-1
     -- self.tt:setY(self.tonguespeed)
    -- end
  elseif(self.tonguey>=self.frogy-0)then
      self.tonguedirection = 1
      -- self.tonguespeed=self.tonguespeed*-1
    end
    local collider2=world:queryRectangleArea(self.frogx-4,self.frogy-4,self.frogWidth+8,self.frogHeight+8,{'Player'})
    if(#collider2>0)then
    --if self.tt:enter('Player') then
      self.playerreset=true
      death=true
    end


    local collider3=world:queryRectangleArea(self.frogx-4,self.frogy-4,self.frogWidth+8,self.frogHeight+8,{'shootable'})
    if(#collider3>0)then
    --if tt:enter('shootable') then
      self.webbed=true
      self.dead=true
    end
    local collider4=world:queryRectangleArea(self.frogx-4,self.frogy-4,self.frogWidth+8,self.frogHeight+8,{'acid'})
  if(#collider4>0)then
   --if tt:enter('acid') then
      self.dead=true
    end
  end
end

function frog:draw()
  love.graphics.draw(self.tongueimage,self.tonguex,self.frogy,0,0.2,self.webbed==true and 0 or (-0.0043*(self.frogy-self.tonguey)))
  --love.graphics.rectangle("fill",self.tonguex,self.tonguey,self.tonguewidth,self.tongueheight)
  love.graphics.draw(self.image, self.frogx, self.frogy, 0, 0.8,0.53,self.frogWidth+10,self.frogHeight+12)----150/self.image:getWidth(), 100/self.image:getHeight(), self.frogWidth, self.frogHeight)
end
