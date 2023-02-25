local utils = require("utils")
local composer = require( "composer" )
local scene = composer.newScene()

local gas 

local function onClickGas(event)
    gas.isVisible = true
end

function scene:create( event )
	local sceneGroup = self.view

    local title = display.newText( utils.boiling.title, 0, 0, utils.font, 60 )
	title.x = display.contentWidth * 0.5
	title.y = 0
	sceneGroup:insert( title )

    for i = 1, #utils.boiling.description do
        local text = display.newText(utils.boiling.description[i], 0, 0, utils.font, 40 )
        text.x = display.contentWidth * 0.5
        text.y = display.contentWidth * 0.1 + i * 50
        sceneGroup:insert( text )
    end

    local stove = display.newImage( utils.boiling.stove )
    stove.x = display.contentWidth * 0.5
    stove.y = display.contentHeight * 0.55
    stove:scale( 2, 2 )
    sceneGroup:insert( stove )

    local pot = display.newImage( utils.boiling.pot )
    pot.x = display.contentWidth * 0.375
    pot.y = display.contentHeight * 0.475
    pot:scale( 0.075, 0.075 )
    sceneGroup:insert( pot )

    local tap = display.newImage( utils.boiling.tap )
    tap.x = display.contentWidth * 0.4
    tap.y = display.contentHeight * 0.675
    tap:scale( 0.05, 0.05 )
    sceneGroup:insert( tap )
    tap:addEventListener( "tap", onClickGas )

    gas = display.newImage( utils.gasImage )
    gas.x = display.contentWidth * 0.4
    gas.y = display.contentHeight * 0.4
    sceneGroup:insert( gas )
    gas.isVisible = false

    for i = 1, #utils.boiling.tip do
        local text = display.newText(utils.boiling.tip[i], 0, 0, utils.font, 40 )
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
		composer.gotoScene( "" )
	end )

	local prev = display.newText( utils.prev, 0, 0, utils.font, 40 )
	prev.x = display.contentWidth * 0.1
	prev.y = display.contentHeight 
	prev:setFillColor( 1, 0.84, 0 )
	sceneGroup:insert( prev )

	prev:addEventListener( "tap", function()
		composer.gotoScene( "pages.fusion" )
	end )
end

scene:addEventListener( "create", scene )

return scene