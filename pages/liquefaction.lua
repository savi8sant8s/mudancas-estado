local utils = require("utils")
local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()

local city
local cloud 

local function onTouch(event)
    local target = event.target
    if event.phase == "began" then
      display.getCurrentStage():setFocus(target)
      target.isFocus = true
      target.markX = target.x
      target.markY = target.y
    elseif event.phase == "moved" then
      if target.isFocus then
        local x = (event.x - event.xStart) + target.markX
        local y = (event.y - event.yStart) + target.markY
        target.x, target.y = x, y
      end
    elseif event.phase == "ended" or event.phase == "cancelled" then
      display.getCurrentStage():setFocus(nil)
      target.isFocus = false
    end
end

local function onCollision(event)
  if event.phase == "began" then
      if (event.object1 == city and event.object2 == cloud) or
          (event.object1 == cloud and event.object2 == city) then
          cloud:play()
      end
  elseif event.phase == "ended" then
    if (event.object1 == city and event.object2 == cloud) or
        (event.object1 == cloud and event.object2 == city) then
        cloud:setFrame(1)
        cloud:pause()
    end
  end
end

Runtime:addEventListener("collision", onCollision)

function scene:create( event )
	local sceneGroup = self.view

  physics.start()
  physics.setGravity(0, 0 )

  local bg = display.newRect( 0, 0, display.contentWidth, display.contentHeight * 2 )
	bg.fill = {
        type = "gradient",
        color1 = { 0, 0.29, 0.68 },
        color2 = { 0, 0.68, 0.94 },
        direction = "right"
    }
	bg.x = display.contentWidth * 0.5
	bg.y = display.contentHeight * 0.5
	sceneGroup:insert( bg )

  local title = display.newText( utils.liquefaction.title, 0, 0, utils.font, 60 )
	title.x = display.contentWidth * 0.5
	title.y = 0
	sceneGroup:insert( title )

  for i = 1, #utils.liquefaction.description do
      local text = display.newText(utils.liquefaction.description[i], 0, 0, utils.font, 40 )
      text.x = display.contentWidth * 0.5
      text.y = display.contentWidth * 0.1 + i * 50
      sceneGroup:insert( text )
  end

  local trees = display.newImage( utils.liquefaction.trees )
  trees.x = display.contentWidth * 0.8
  trees.y = display.contentHeight * 0.625
  trees:scale( 0.75, 0.75 )
  sceneGroup:insert( trees )

  city = display.newImage( utils.liquefaction.city )
  city.x = display.contentWidth * 0.3
  city.y = display.contentHeight * 0.6
  city.width = 400
  city.height = 185
  city:scale( 1, 1 )
  sceneGroup:insert( city )
  physics.addBody(city, "static")

  local cloudSheetOptions = {
    width = 360,
    height = 430,
    numFrames = 5
  }

  cloud = graphics.newImageSheet( utils.liquefaction.cloud, cloudSheetOptions )
  local sequenceData = {
    { name = "normal", start = 1, count = 5, time = 500, loopCount = 0 }
  }
  cloud = display.newSprite( cloud, sequenceData )
  cloud.x = display.contentWidth * 0.8
  cloud.y = display.contentHeight * 0.6
  cloud.width = 180
  cloud.height = 215
  cloud:scale( 0.5, 0.5 )
  sceneGroup:insert( cloud )
  cloud:addEventListener("touch", onTouch)
  physics.addBody(cloud, "dynamic", {isSensor = true})

  for i = 1, #utils.liquefaction.tip do
      local text = display.newText(utils.liquefaction.tip[i], 0, 0, utils.font, 40 )
      text.x = display.contentWidth * 0.5
      text.y = display.contentHeight * 0.75 + i * 50
      sceneGroup:insert( text )
  end

  local rectBorder = display.newRect( 0, 0, display.contentWidth * 0.6, display.contentHeight * 0.125 )
  rectBorder.x = display.contentWidth * 0.5
  rectBorder.y = display.contentHeight * 0.825
  rectBorder.strokeWidth = 4
  rectBorder:setFillColor( 0, 0, 0, 0 )
  rectBorder:setStrokeColor( 1, 1, 1 )
  sceneGroup:insert( rectBorder )

  local next = display.newText( utils.next, 0, 0, utils.font, 40 )
	next.x = display.contentWidth * 0.9
	next.y = display.contentHeight 
	next:setFillColor( 1, 0.84, 0 )
	sceneGroup:insert( next )

	next:addEventListener( "tap", function()
		composer.gotoScene( "pages.sublimation", "fade" )
	end )

	local prev = display.newText( utils.prev, 0, 0, utils.font, 40 )
	prev.x = display.contentWidth * 0.1
	prev.y = display.contentHeight 
	prev:setFillColor( 1, 0.84, 0 )
	sceneGroup:insert( prev )

	prev:addEventListener( "tap", function()
		composer.gotoScene( "pages.boiling", "fade" )
	end )
end

scene:addEventListener( "create", scene )

return scene