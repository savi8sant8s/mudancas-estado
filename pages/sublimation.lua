local utils = require("utils")
local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()

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

function scene:create( event )
	local sceneGroup = self.view

    physics.start()
    physics.setGravity(0, 0 )

    local title = display.newText( utils.sublimation.title, 0, 0, utils.font, 60 )
	title.x = display.contentWidth * 0.5
	title.y = 0
	sceneGroup:insert( title )

    for i = 1, #utils.sublimation.description do
        local text = display.newText(utils.sublimation.description[i], 0, 0, utils.font, 40 )
        text.x = display.contentWidth * 0.5
        text.y = display.contentWidth * 0.1 + i * 50
        sceneGroup:insert( text )
    end

    
    local pot1 = display.newImage( utils.sublimation.pot1 )
    pot1.x = display.contentWidth * 0.5
    pot1.y = display.contentHeight * 0.6
    pot1:scale( 0.1, 0.1 )
    sceneGroup:insert( pot1 )
    physics.addBody(pot1, "static")

    local pot2 = display.newImage( utils.sublimation.pot2 )
    pot2.x = display.contentWidth * 0.5
    pot2.y = display.contentHeight * 0.5
    pot2:scale( 0.1, 0.1 )
    sceneGroup:insert( pot2 )
    pot2:addEventListener("touch", onTouch)
    physics.addBody(pot2, "static")
    
    for i = 1, #utils.sublimation.tip do
        local text = display.newText(utils.sublimation.tip[i], 0, 0, utils.font, 40 )
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
		composer.gotoScene( "pages.about" )
	end )

	local prev = display.newText( utils.prev, 0, 0, utils.font, 40 )
	prev.x = display.contentWidth * 0.1
	prev.y = display.contentHeight 
	prev:setFillColor( 1, 0.84, 0 )
	sceneGroup:insert( prev )

	prev:addEventListener( "tap", function()
		composer.gotoScene( "pages.boiling" )
	end )
end

scene:addEventListener( "create", scene )

return scene