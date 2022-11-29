WINDOW_WIDTH = 1080
WINDOW_HEIGHT = 720
gravity=200
playerx=0
playery=0
visible=true
death=false
nextlevel=false
nextinsect=false
level="1"
insect=1
insect_level={'horsefly_levels','bombardierbeetle_levels','glasswingbutterfly_levels','barkspider_levels'}
gotovictory=false
tongue={}
-- Require Files --
Class = require 'class'
require 'States/BaseState'
require 'StateMachine'
require 'States/TitleScreenState'
require 'States/VictoryState'
require 'States/InstructionState'
require 'States/PlayState'
require 'States/LevelSelectState'
require 'States/StoryState'
require 'States/CreditState'
require 'playerassets/player'
require 'playerassets/interface'
require 'playerassets/bark_spider'
require 'playerassets/horsefly'
require 'playerassets/glasswing_butterfly'
require 'playerassets/bombardier_beetle'
require 'enemies/frog'
require 'enemies/lizard'
require 'enemies/bird'
require 'spawner'
require 'destroyer'
require('libraries/show')
push = require "push"

--------------------------------------------------------------------------------requiring necessary libraries
wf= require 'libraries/windfield/windfield'
anim8=require 'libraries/anim8/anim8'
sti= require 'libraries/Simple-Tiled-Implementation/sti'
cameraFile = require 'libraries/hump/camera'
--------------------------------------------------------------------------------
--love.physics.setMeter(10)
world= wf.newWorld(0,gravity,false)
world:setQueryDebugDrawing(true)
world:addCollisionClass('spawn')
world:addCollisionClass('frog')
world:addCollisionClass('tongue',{ignores = {'frog'}})
world:addCollisionClass('Player',{ignores = {'spawn','tongue'}})
world:addCollisionClass('Platform')
world:addCollisionClass('platform')
world:addCollisionClass('walls')
world:addCollisionClass('webs')
world:addCollisionClass('acid',{ignores = {'acid','Player','spawn'}})
--world:addCollisionClass('frog')
world:addCollisionClass('shootable')--,{ignores={'frog'}})
world:addCollisionClass('lizard')
world:addCollisionClass('bird')
world:addCollisionClass('water')
world:addCollisionClass('end')
world:addCollisionClass('flower')
--world:addCollisionClass('tongue',{ignores = {'frog','Player'}})

cam =cameraFile()


function love.load()
  wind_x,wind_y=love.window.getMode()
  love.window.setTitle("Morphogen")
  push:setupScreen(WINDOW_WIDTH, WINDOW_HEIGHT,wind_x,wind_y,{
      vsync = true,
      fullscreen = true,
      resizable = true,
      pixelperfect=false, highdpi = true ,stretched = true
  })
  love.graphics.setFont(love.graphics.newFont(40))
  gStateMachine=StateMachine
 {
   ['title']= function() return TitleScreenState() end,
   ['story']= function() return StoryState() end,
   ['play']= function() return PlayState() end,
   ['instruction']= function() return InstructionState() end,
   ['victory']= function() return VictoryState() end,
   ['level select']= function() return LevelSelectState() end,
   ['credits']= function() return CreditState() end

 }
 gStateMachine:change('title')
love.mouse.buttonsPressed = {}
keyboard_check={}
--------------------------------------------------------------------------------music
bombardier_beetlemusic=love.audio.newSource('Music/Beetlemusic.wav',"stream")
bombardier_beetlemusic:setLooping(true)
bombardier_beetlemusic:setVolume(0.5)
horseflymusic=love.audio.newSource('Music/Horseflymusic.wav',"stream")
horseflymusic:setLooping(true)
horseflymusic:setVolume(0.5)
bark_spidermusic=love.audio.newSource('Music/Spidermusic.wav',"stream")
bark_spidermusic:setLooping(true)
bark_spidermusic:setVolume(0.5)
butterfly_music=love.audio.newSource('Music/Butterflymusic.wav',"stream")
butterfly_music:setLooping(true)
butterfly_music:setVolume(0.5)
--------------------------------------------------------------------------------background effect
acidsound=love.audio.newSource('Soundeffects/beetle_acid.wav','static')
butterfly_special=love.audio.newSource('Soundeffects/butterfly_invis.wav','static')
fly_special=love.audio.newSource('Soundeffects/fly_zoomer1.wav','static')
spider_special=love.audio.newSource('Soundeffects/web_shoot.wav','static')
deathx=love.audio.newSource('Soundeffects/deathx.wav','static')
end

function love.resize(w,h)
  push:resize(w,h)
end

function love.update(dt)
  gStateMachine:update(dt)
  love.mouse.buttonsPressed = {}
  keyboard_check={}
end


function love.mousepressed(x, y, button, isTouch)
  love.mouse.buttonsPressed[button] = true
  x1,y1=push:toGame(x,y)

  if x1~=nil and y1~=nil then
     gStateMachine:mouse_pressed(x1,y1)
  end
end

function love.keypressed(key, scancode, isrepeat)
  keyboard_check[key]=true
  -- if key == 'escape' then
  --   love.event.quit()
  -- end
  gStateMachine:key_pressed(key)
end

function Keyboard_was_Pressed(key)
  if keyboard_check[key] then
    return true
  else
    return false
  end
end

function love.mouse.wasPressed(button)
    if love.mouse.buttonsPressed[button] then
      return true
    else
      return false
    end
end

function love.keyreleased(key)
  gStateMachine:key_released(key)
end


function love.draw()
   push:start()
   gStateMachine:render()
  --world:draw()
     --love.graphics.print(yi)
   --love.graphics.print(here)
   push:finish()

end
