local utils = require("utils")
local composer = require( "composer" )
local scene = composer.newScene()
local physics = require("physics")

local objects = {}

physics.start()
physics.setGravity(0, 0)

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
      if (event.object1 == objects.solidImage and event.object2 == objects.solid) or
          (event.object1 == objects.solid and event.object2 == objects.solidImage) then
          objects.solid.fill = {1, 0.84, 0}
          transition.to(objects.solidImage, {time = 1000, alpha = 0})
      end
      if (event.object1 == objects.gasImage and event.object2 == objects.gas) or
          (event.object1 == objects.gas and event.object2 == objects.gasImage) then
          objects.gas.fill = {1, 0.84, 0}
          transition.to(objects.gasImage, {time = 1000, alpha = 0})
      end
      if (event.object1 == objects.liquidImage and event.object2 == objects.liquid) or
          (event.object1 == objects.liquid and event.object2 == objects.liquidImage) then
          objects.liquid.fill = {1, 0.84, 0}
          transition.to(objects.liquidImage, {time = 1000, alpha = 0})
      end
  end
end

Runtime:addEventListener("collision", onCollision)

function scene:create( event )
	local sceneGroup = self.view

	for i = 1, #utils.phisicalStates do
		local text = display.newText(utils.phisicalStates[i], 0, 0, utils.font, 40 )
		text.x = display.contentWidth * 0.5
		text.y = display.contentHeight * 0.1 + i * 50
		sceneGroup:insert( text )
	end

  objects.solid = display.newText( utils.solid, 0, 0, utils.font, 40 )
  objects.solid.x = display.contentWidth * 0.7
  objects.solid.y = display.contentHeight * 0.65
  sceneGroup:insert( objects.solid )
  physics.addBody(objects.solid, "static")

  objects.liquid = display.newText( utils.liquid, 0, 0, utils.font, 40 )
  objects.liquid.x = display.contentWidth * 0.7
  objects.liquid.y = display.contentHeight * 0.5
  sceneGroup:insert( objects.liquid )
  physics.addBody(objects.liquid, "static")

  objects.gas = display.newText( utils.gas, 0, 0, utils.font, 40 )
  objects.gas.x = display.contentWidth * 0.7
  objects.gas.y = display.contentHeight * 0.35
  sceneGroup:insert( objects.gas )
  physics.addBody(objects.gas, "static")

  objects.solidImage = display.newImage( utils.solidImage )
  objects.solidImage.x = display.contentWidth * 0.3
  objects.solidImage.y = display.contentHeight * 0.5
  objects.solidImage:scale( 0.5, 0.5 )
  sceneGroup:insert( objects.solidImage )
  physics.addBody(objects.solidImage, "static")
  objects.solidImage:addEventListener( "touch", onTouch)
  
  objects.gasImage = display.newImage( utils.gasImage )
  objects.gasImage.x = display.contentWidth * 0.3
  objects.gasImage.y = display.contentHeight * 0.65
  objects.gasImage:scale( 0.5, 0.5 )
  sceneGroup:insert( objects.gasImage )
  physics.addBody(objects.gasImage, "static")
  objects.gasImage:addEventListener( "touch", onTouch)

  objects.liquidImage = display.newImage( utils.liquidImage )
  objects.liquidImage.x = display.contentWidth * 0.3
  objects.liquidImage.y = display.contentHeight * 0.35
  objects.liquidImage:scale( 0.5, 0.5 )
  sceneGroup:insert( objects.liquidImage )
  physics.addBody(objects.liquidImage, "static")
  objects.liquidImage:addEventListener( "touch", onTouch)

  for i = 1, #utils.tipPhisicalStates do
      local text = display.newText(utils.tipPhisicalStates[i], 0, 0, utils.font, 40 )
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
		composer.gotoScene( "pages.atoms" )
	end )

	local prev = display.newText( utils.prev, 0, 0, utils.font, 40 )
	prev.x = display.contentWidth * 0.1
	prev.y = display.contentHeight
	prev:setFillColor( 1, 0.84, 0 )
	sceneGroup:insert( prev )

	prev:addEventListener( "tap", function()
		composer.gotoScene( "pages.contracapa" )
	end )
end

scene:addEventListener( "create", scene )

return scene