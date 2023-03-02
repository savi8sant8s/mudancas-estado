local utils = require("utils")
local composer = require( "composer" )
local scene = composer.newScene()
local physics = require("physics")
local timer = require("timer")

local images = {}
local texts = {}
local countHidedImages = 0

local function puzzleResolved()
    countHidedImages = countHidedImages + 1
    if countHidedImages == 3 then
      timer.performWithDelay( 1000, function()
        transition.to(texts.solid, {time = 2000, x = display.contentWidth * 0.5, y = display.contentHeight * 0.2})
        transition.to(images.solid, {time = 2000, x = display.contentWidth * 0.5, y = display.contentHeight * 0.3})
        transition.to(images.solid, {time = 2000, alpha = 1})
        transition.to(texts.gas, {time = 2000, x = display.contentWidth * 0.5, y = display.contentHeight * 0.6})
        transition.to(images.gas, {time = 2000, x = display.contentWidth * 0.5, y = display.contentHeight * 0.7})
        transition.to(images.gas, {time = 2000, alpha = 1})
        transition.to(texts.liquid, {time = 2000, x = display.contentWidth * 0.5, y = display.contentHeight * 0.4})
        transition.to(images.liquid, {time = 2000, x = display.contentWidth * 0.5, y = display.contentHeight * 0.5})
        transition.to(images.liquid, {time = 2000, alpha = 1})
      end)
    end
end

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
      if (event.object1 == images.solid and event.object2 == texts.solid) or
          (event.object1 == texts.solid and event.object2 == images.solid) then
          texts.solid.fill = {1, 0.84, 0}
          transition.to(images.solid, {time = 1000, alpha = 0})
          puzzleResolved()
      end
      if (event.object1 == images.gas and event.object2 == texts.gas) or
          (event.object1 == texts.gas and event.object2 == images.gas) then
          texts.gas.fill = {1, 0.84, 0}
          transition.to(images.gas, {time = 1000, alpha = 0})
          puzzleResolved()
      end
      if (event.object1 == images.liquid and event.object2 == texts.liquid) or
          (event.object1 == texts.liquid and event.object2 == images.liquid) then
          texts.liquid.fill = {1, 0.84, 0}
          transition.to(images.liquid, {time = 1000, alpha = 0})
          puzzleResolved()
      end
  end
end

Runtime:addEventListener("collision", onCollision)

function scene:create( event )
	local sceneGroup = self.view

  physics.start()
  physics.setGravity(0, 0)

	for i = 1, #utils.phisicalStates do
		local text = display.newText(utils.phisicalStates[i], 0, 0, utils.font, 50 )
		text.x = display.contentWidth * 0.5
		text.y = i * 50
		sceneGroup:insert( text )
	end

  texts.solid = display.newText( utils.solid, 0, 0, utils.font, 40 )
  texts.solid.x = display.contentWidth * 0.7
  texts.solid.y = display.contentHeight * 0.65
  sceneGroup:insert( texts.solid )
  physics.addBody(texts.solid, "static", {bounce = 0.5})

  texts.liquid = display.newText( utils.liquid, 0, 0, utils.font, 40 )
  texts.liquid.x = display.contentWidth * 0.7
  texts.liquid.y = display.contentHeight * 0.5
  sceneGroup:insert( texts.liquid )
  physics.addBody(texts.liquid, "static")

  texts.gas = display.newText( utils.gas, 0, 0, utils.font, 40 )
  texts.gas.x = display.contentWidth * 0.7
  texts.gas.y = display.contentHeight * 0.35
  sceneGroup:insert( texts.gas )
  physics.addBody(texts.gas, "static")

  images.solid = display.newImage( utils.solidImage )
  images.solid.x = display.contentWidth * 0.3
  images.solid.y = display.contentHeight * 0.5
  images.solid:scale( 0.5, 0.5 )
  sceneGroup:insert( images.solid )
  physics.addBody(images.solid, "dynamic", {isSensor = true})
  images.solid:addEventListener( "touch", onTouch)
  
  images.gas = display.newImage( utils.gasImage )
  images.gas.x = display.contentWidth * 0.3
  images.gas.y = display.contentHeight * 0.65
  images.gas:scale( 0.5, 0.5 )
  sceneGroup:insert( images.gas )
  physics.addBody(images.gas, "dynamic", {isSensor = true})
  images.gas:addEventListener( "touch", onTouch)

  images.liquid = display.newImage( utils.liquidImage )
  images.liquid.x = display.contentWidth * 0.3
  images.liquid.y = display.contentHeight * 0.35
  images.liquid:scale( 0.5, 0.5 )
  sceneGroup:insert( images.liquid )
  physics.addBody(images.liquid, "dynamic", {isSensor = true})
  images.liquid:addEventListener( "touch", onTouch)

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
		composer.gotoScene( "pages.atoms", "fade" )
	end )

	local prev = display.newText( utils.prev, 0, 0, utils.font, 40 )
	prev.x = display.contentWidth * 0.1
	prev.y = display.contentHeight
	prev:setFillColor( 1, 0.84, 0 )
	sceneGroup:insert( prev )

	prev:addEventListener( "tap", function()
		composer.gotoScene( "pages.back-cover", "fade" )
	end )
end

scene:addEventListener( "create", scene )

return scene