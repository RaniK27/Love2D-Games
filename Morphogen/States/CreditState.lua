CreditState = Class{__includes = BaseState}

function CreditState:init()
  for k,v in pairs(enemies)do
    table.remove(enemies,k)
  end
  destroyAll()
  self.image=love.graphics.newImage('States/Credits menu.png')
end

function CreditState:update(dt)
  if love.keyboard.isDown('escape') then
    love.event.quit()
  end
end

function CreditState:render()
  love.graphics.draw(self.image,0,0)
end
