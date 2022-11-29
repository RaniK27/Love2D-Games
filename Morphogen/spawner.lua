Platforms={}
Walls={}
Spawns={}
Water={}
Ends={}
flower={}

function map_spawn(mapName)
  gameMap = sti("maps/"..mapName..".lua")
  for i,obj in pairs(gameMap.layers['Platform'].objects)do
    spawnplatform(obj.x,obj.y,obj.width,obj.height)
  end

  for i,obj in pairs(gameMap.layers['walls'].objects)do
    spawnwalls(obj.x,obj.y,obj.width,obj.height)
  end

  for i,obj in pairs(gameMap.layers['frog'].objects)do
    spawnfrogs(obj.x,obj.y)
  end

  for i,obj in pairs(gameMap.layers['lizard'].objects)do
    spawnlizards(obj.x,obj.y)
  end

  for i,obj in pairs(gameMap.layers['bird'].objects)do
    spawnbirds(obj.x,obj.y)
  end

  for i,obj in pairs(gameMap.layers['respawn_point'].objects)do
    spawnrespawn(obj.x,obj.y,obj.width,obj.height)
  end

  for i,obj in pairs(gameMap.layers['water'].objects)do
    spawnwater(obj.x,obj.y,obj.width,obj.height)
  end

  for i,obj in pairs(gameMap.layers['end_point'].objects)do
    spawnend(obj.x,obj.y,obj.width,obj.height)
  end


    -- for i,obj in pairs(gameMap.layers['flower'].objects)do
    --   spawnflower(obj.x,obj.y,obj.width,obj.height)
    -- end

end

function spawnplatform(x,y,w,h)
  local collider=world:newRectangleCollider(x,y,w,h,{collision_class="Platform"})
  collider:setCollisionClass('Platform')
  collider:setType('static')
  table.insert(Platforms,collider)
end

function spawnwalls(x,y,w,h)
  local collider=world:newRectangleCollider(x,y,w,h,{collision_class="walls"})
  collider:setType('static')
  table.insert(Walls,collider)
end

function spawnfrogs(x,y)
  local collider=frog(x,y)
  table.insert(enemies,collider)
end

function spawnlizards(x,y)
  local collider=lizard(x,y)
  table.insert(enemies,collider)
end

function spawnbirds(x,y)
  local collider=bird(x,y)
  table.insert(enemies,collider)
end

function spawnrespawn(x,y,w,h)
  local collider=world:newRectangleCollider(x,y,w,h,{collision_class='spawn'})
  collider:setCollisionClass('spawn')
  collider:setType('static')
  table.insert(Spawns,collider)
end

function spawnwater(x,y,w,h)
  local collider=world:newRectangleCollider(x,y,w,h,{collision_class="water"})
  collider:setType('static')
  table.insert(Water,collider)
end

function spawnend(x,y,w,h)
  local collider=world:newRectangleCollider(x,y,w,h,{collision_class="end"})
  collider:setType('static')
  table.insert(Ends,collider)
end

function spawnflower(x,y,w,h)
  local collider=world:newRectangleCollider(x,y,w,h,{collision_class="flower"})
  collider:setCollisionClass('flower')
  collider:setType('static')
  table.insert(flower,collider)
end
