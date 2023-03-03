local utils = require("utils")
local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()

local lighter
local ice

local function onTouch(event)
    local target = event.target
    if event.phase == "began" then
      display.getCurrentStage():setFocus(target)
      target.isFocus = true
      target.markX = target.x
      target.markY = target.y
    elseif event.phase == "moved" then
      if target.isFocus then
        transition.to(lighter, {time = 100, rotation = -75})
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
      if (event.object1 == lighter and event.object2 == ice) or
          (event.object1 == ice and event.object2 == lighter) then
          ice:play()
      end
  end
end

Runtime:addEventListener("collision", onCollision)

function scene:create( event )
	local sceneGroup = self.view

  physics.start()
  physics.setGravity(0, 0 )

  local title = display.newText( utils.fusion.title, 0, 0, utils.font, 60 )
  title.x = display.contentWidth * 0.5
  title.y = 0
  sceneGroup:insert( title )

  for i = 1, #utils.fusion.description do
      local text = display.newText(utils.fusion.description[i], 0, 0, utils.font, 40 )
      text.x = display.contentWidth * 0.5
      text.y = display.contentWidth * 0.1 + i * 50
      sceneGroup:insert( text )
  end

  local iceSheetOptions = {
    width = 300,
    height = 300,
    numFrames = 10
  }
  ice = graphics.newImageSheet( utils.fusion.ice, iceSheetOptions )
  local sequenceData = {
    { name = "normal", start = 1, count = 10, time = 1500, loopCount = 1 }
  }
  ice = display.newSprite( ice, sequenceData )
  ice.x = display.contentWidth * 0.3
  ice.y = display.contentHeight * 0.55
  ice:scale( 1.5, 1.5 )
  sceneGroup:insert( ice )
  physics.addBody( ice, "static" )

  local lighterSheetOptions = {
    width = 100,
    height = 330,
    numFrames = 3
  }
  lighter = graphics.newImageSheet( utils.fusion.lighter, lighterSheetOptions )
  local sequenceData = {
    { name = "normal", start = 1, count = 10, time = 75, loopCount = 0 }
  }
  lighter = display.newSprite( lighter, sequenceData )
  lighter.x = display.contentWidth * 0.8
  lighter.y = display.contentHeight * 0.55
  lighter.width = 75
  lighter.height = 150
  lighter:scale( 0.5, 0.5 )
  sceneGroup:insert( lighter )
  lighter:addEventListener("touch", onTouch)
  physics.addBody(lighter, "dynamic", {isSensor = true })
  lighter:play()

  for i = 1, #utils.fusion.tip do
      local text = display.newText(utils.fusion.tip[i], 0, 0, utils.font, 40 )
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
		composer.gotoScene( "pages.boiling", "fade" )
	end )

	local prev = display.newText( utils.prev, 0, 0, utils.font, 40 )
	prev.x = display.contentWidth * 0.1
	prev.y = display.contentHeight 
	prev:setFillColor( 1, 0.84, 0 )
	sceneGroup:insert( prev )

	prev:addEventListener( "tap", function()
		composer.gotoScene( "pages.solidification", "fade" )
	end )
end

scene:addEventListener( "create", scene )

return scene