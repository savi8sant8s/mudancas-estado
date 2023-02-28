local utils = require("utils")
local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local title = display.newText( utils.title, 0, 0, utils.font, 60 )
	title.x = display.contentWidth * 0.5
	title.y = display.contentHeight * 0.2	
	sceneGroup:insert( title )

	local icon = display.newImage( utils.logo )
	icon.x = display.contentWidth * 0.5
	icon.y = display.contentHeight * 0.5
	icon:scale( 2, 2 )
	sceneGroup:insert( icon )

	local next = display.newText( utils.next, 0, 0, utils.font, 40 )
	next.x = display.contentWidth * 0.9
	next.y = display.contentHeight
	next:setFillColor( 1, 0.84, 0 )
	sceneGroup:insert( next )

	next:addEventListener( "tap", function()
		composer.gotoScene( "pages.back-cover" )
	end )
end

scene:addEventListener( "create", scene )

return scene