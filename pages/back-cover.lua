local utils = require("utils")
local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local title = display.newText( utils.title, 0, 0, utils.font, 60 )
	title.x = display.contentWidth * 0.5
	sceneGroup:insert( title )

	local summary = display.newText( utils.summary, 0, 0, utils.font, 50 )
	summary.x = display.contentWidth * 0.5
	summary.y = display.contentHeight * 0.25
	sceneGroup:insert( summary )

	local rectBorder = display.newRect( 0, 0, display.contentWidth * 0.6, display.contentHeight * 0.5 )
	rectBorder.x = display.contentWidth * 0.5
	rectBorder.y = display.contentHeight * 0.45
	rectBorder.strokeWidth = 4
	rectBorder:setFillColor( 0, 0, 0, 0 )
	rectBorder:setStrokeColor( 1, 1, 1 )
	sceneGroup:insert( rectBorder )

	local line = display.newLine( 0, 0, display.contentWidth * 0.5, 0 )
	line.x = display.contentWidth * 0.25
	line.y = display.contentHeight * 0.3
	line.strokeWidth = 3
	line:setStrokeColor( 1, 1, 1 )
	sceneGroup:insert( line )

	for i = 1, #utils.topics do
		local topic = display.newText(utils.topics[i], 0, 0, utils.font, 40 )
		topic.x = display.contentWidth * 0.5
		topic.y = display.contentHeight * 0.3 + i * 50
		sceneGroup:insert( topic )
	end

	local next = display.newText( utils.next, 0, 0, utils.font, 40 )
	next.x = display.contentWidth * 0.9
	next.y = display.contentHeight
	next:setFillColor( 1, 0.84, 0 )
	sceneGroup:insert( next )

	next:addEventListener( "tap", function()
		composer.gotoScene( "pages.physical-states", "fade" )
	end )

	local prev = display.newText( utils.prev, 0, 0, utils.font, 40 )
	prev.x = display.contentWidth * 0.1
	prev.y = display.contentHeight
	prev:setFillColor( 1, 0.84, 0 )
	sceneGroup:insert( prev )

	prev:addEventListener( "tap", function()
		composer.gotoScene( "pages.cover", "fade" )
	end )
end

scene:addEventListener( "create", scene )

return scene