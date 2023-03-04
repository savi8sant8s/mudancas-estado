local utils = require("utils")
local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()

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

    local title = display.newText( utils.about.title, 0, 0, utils.font, 60 )
    title:setFillColor( 1, 0.84, 0 )
	title.x = display.contentWidth * 0.5
	title.y = 0
	sceneGroup:insert( title )

    for i = 1, #utils.about.description do
        local text = display.newText(utils.about.description[i], 0, 0, utils.font, 40 )
        text.x = display.contentWidth * 0.5
        text.y = display.contentWidth * 0.1 + i * 50
        sceneGroup:insert( text )
    end

    local viewMore = display.newText( utils.about.viewMore, 0, 0, utils.font, 40 )
    viewMore.x = display.contentWidth * 0.5
    viewMore.y = display.contentHeight * 0.6
    viewMore:setFillColor( 1, 0.84, 0 )
    sceneGroup:insert( viewMore )

    local viewMoreLink = display.newText( utils.about.viewMoreLink, 0, 0, utils.font, 40 )
    viewMoreLink.x = display.contentWidth * 0.5
    viewMoreLink.y = display.contentHeight * 0.6 + 50
    sceneGroup:insert( viewMoreLink )
    
    local sourceCode = display.newText( utils.about.sourceCode, 0, 0, utils.font, 40 )
    sourceCode.x = display.contentWidth * 0.5
    sourceCode.y = display.contentHeight * 0.7 + 100
    sourceCode:setFillColor( 1, 0.84, 0 )
    sceneGroup:insert( sourceCode )

    local sourceCodeLink = display.newText( utils.about.sourceCodeLink, 0, 0, utils.font, 40 )
    sourceCodeLink.x = display.contentWidth * 0.5
    sourceCodeLink.y = display.contentHeight * 0.7 + 150
    sceneGroup:insert( sourceCodeLink )

	local prev = display.newText( utils.prev, 0, 0, utils.font, 40 )
	prev.x = display.contentWidth * 0.1
	prev.y = display.contentHeight 
	prev:setFillColor( 1, 0.84, 0 )
	sceneGroup:insert( prev )

	prev:addEventListener( "tap", function()
		composer.gotoScene( "pages.sublimation", "fade" )
	end )
end

scene:addEventListener( "create", scene )

return scene