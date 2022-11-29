function destroyAll()



  for k,v in pairs(Platforms)do
    --v:destroy()
    table.remove(Platforms,k)
  end

  for k,v in pairs(Walls)do
    --v:destroy()
    table.remove(Walls,k)
  end

  -- for k,v in pairs(enemies)do
  --   v.collider:destroy()
  --   table.remove(enemies,k)
  -- end

  for k,v in pairs(Spawns)do
    --v:destroy()
    table.remove(Spawns,k)
  end
  

  for k,v in pairs(Water)do
    --v:destroy()
    table.remove(Spawns,k)
  end

  for k,v in pairs(Ends)do
    --v:destroy()
    table.remove(Ends,k)
  end
  for k,v in pairs(flower)do
    --v:destroy()
    table.remove(Ends,k)
  end

  for _, body in pairs(world:getBodies()) do
        body:destroy()
  end
end
