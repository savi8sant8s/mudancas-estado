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

    local title = display.newText( utils.solidification.title, 0, 0, utils.font, 60 )
	title.x = display.contentWidth * 0.5
	title.y = 0
	sceneGroup:insert( title )

    for i = 1, #utils.solidification.description do
        local text = display.newText(utils.solidification.description[i], 0, 0, utils.font, 40 )
        text.x = display.contentWidth * 0.5
        text.y = display.contentWidth * 0.1 + i * 50
        sceneGroup:insert( text )
    end

    local bottle = display.newImage( utils.solidification.bottle )
    bottle.x = display.contentWidth * 0.3
    bottle.y = display.contentHeight * 0.55
    bottle:scale( 0.5, 0.5 )
    sceneGroup:insert( bottle )
    bottle:addEventListener("touch", onTouch)
    physics.addBody(bottle, "static")

    local freezer = display.newImage( utils.solidification.freezer )
    freezer.x = display.contentWidth * 0.7
    freezer.y = display.contentHeight * 0.55
    freezer:scale( 1.5, 1.5 )
    sceneGroup:insert( freezer )
    physics.addBody(freezer, "static")

    for i = 1, #utils.solidification.tip do
        local text = display.newText(utils.solidification.tip[i], 0, 0, utils.font, 40 )
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
		composer.gotoScene( "pages.fusion" )
	end )

	local prev = display.newText( utils.prev, 0, 0, utils.font, 40 )
	prev.x = display.contentWidth * 0.1
	prev.y = display.contentHeight 
	prev:setFillColor( 1, 0.84, 0 )
	sceneGroup:insert( prev )

	prev:addEventListener( "tap", function()
		composer.gotoScene( "pages.atoms" )
	end )
end

scene:addEventListener( "create", scene )

return scene