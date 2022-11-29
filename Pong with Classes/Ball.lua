Ball = Class{}

function Ball:init(x,y,width,height)
  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.dy = math.random(2)==1 and 500 or -500
  self.dx = math.random(-550,550)
end

function Ball:reset()
  self.x = window_width/2-5
  self.y = window_height/2-5
  self.dy = math.random(2)==1 and 500 or -500
  self.dx = math.random(-250,550)
end

function Ball:update(dt)
  self.x = self.x+self.dx*dt
  self.y = self.y+self.dy*dt
end

function Ball:collides(paddle)
  return self.x<paddle.x+paddle.width and
         self.x+self.width>paddle.x and
         self.y<paddle.y+paddle.height and
         self.y+self.height>paddle.y
  end


function Ball:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
