local utils = require("utils")
local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

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

	local title = display.newText( utils.title, 0, 0, utils.font, 60 )
	title.x = display.contentWidth * 0.5
	sceneGroup:insert( title )

	local icon = display.newImage( utils.logo )
	icon.x = display.contentWidth * 0.5
	icon.y = display.contentHeight * 0.5
	icon:scale( 2.5, 2.5 )
	sceneGroup:insert( icon )

	local next = display.newText( utils.next, 0, 0, utils.font, 40 )
	next.x = display.contentWidth * 0.9
	next.y = display.contentHeight
	next:setFillColor( 1, 0.84, 0 )
	sceneGroup:insert( next )

	next:addEventListener( "tap", function()
		composer.gotoScene( "pages.back-cover", "fade" )
	end )
end

scene:addEventListener( "create", scene )

return scene