local utils = require("utils")
local composer = require( "composer" )
local scene = composer.newScene()

local turnOn = false
local turnOn2 = false
local button
local button2
local kettle
local kettle2

function onTurnOn()
    turnOn = not turnOn
    if turnOn then
        transition.to(button, {time = 100, rotation = -15})
        kettle:setSequence( "normal" )
        kettle:play()
    else
        transition.to(button, {time = 100, rotation = 90})
        kettle:setFrame( 1 )
        kettle:pause()
    end
end

function onTurnOn2()
    turnOn2 = not turnOn2
    if turnOn2 then
        transition.to(button2, {time = 100, rotation = -15})
        kettle2:setSequence( "normal" )
        kettle2:play()
    else
        transition.to(button2, {time = 100, rotation = 90})
        kettle2:setFrame( 1 )
        kettle2:pause()
    end
end

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
    
    local title = display.newText( utils.boiling.title, 0, 0, utils.font, 60 )
	title.x = display.contentWidth * 0.5
	sceneGroup:insert( title )

    for i = 1, #utils.boiling.description do
        local text = display.newText(utils.boiling.description[i], 0, 0, utils.font, 40 )
        text.x = display.contentWidth * 0.5
        text.y = display.contentWidth * 0.1 + i * 50
        sceneGroup:insert( text )
    end

    local stove = display.newImage( utils.boiling.stove )
    stove.x = display.contentWidth * 0.5
    stove.y = display.contentHeight * 0.6
    stove:scale( 2, 2 )
    sceneGroup:insert( stove )

    local kettleSheetOptions = {
        width = 330,
        height = 320,
        numFrames = 5
    }
    kettle = graphics.newImageSheet( utils.boiling.kettle, kettleSheetOptions )
    local sequenceData = {
    { name = "normal", start = 1, count = 5, time = 500, loopCount = 0 }
    }
    kettle = display.newSprite( kettle, sequenceData )
    kettle.x = display.contentWidth * 0.3
    kettle.y = display.contentHeight * 0.45
    kettle:scale( 1, 1 )
    sceneGroup:insert( kettle )

    local kettle2SheetOptions = {
        width = 330,
        height = 320,
        numFrames = 5
    }
    kettle2 = graphics.newImageSheet( utils.boiling.kettle, kettle2SheetOptions )
    local sequenceData = {
    { name = "normal", start = 1, count = 5, time = 500, loopCount = 0 }
    }
    kettle2 = display.newSprite( kettle2, sequenceData )
    kettle2.x = display.contentWidth * 0.7
    kettle2.y = display.contentHeight * 0.45
    kettle2:scale( 1, 1 )
    kettle2.xScale = -kettle2.xScale
    sceneGroup:insert( kettle2 )

    button = display.newRect( 0, 0, 30, 0 )
    button.x = display.contentWidth * 0.365
    button.y = display.contentHeight * 0.68
    button.strokeWidth = 10
    button.rotation = 90
    button:setStrokeColor( 1, 0.84, 0.1 )
    sceneGroup:insert( button )
    button:addEventListener( "tap", onTurnOn )
    
    button2 = display.newRect( 0, 0, 30, 0 )
    button2.x = display.contentWidth * 0.64
    button2.y = display.contentHeight * 0.68
    button2.strokeWidth = 10
    button2.rotation = 90
    button2:setStrokeColor( 1, 0.84, 0.1 )
    sceneGroup:insert( button2 )
    button2:addEventListener( "tap", onTurnOn2 )

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
		composer.gotoScene( "pages.liquefaction", "fade" )
	end )

	local prev = display.newText( utils.prev, 0, 0, utils.font, 40 )
	prev.x = display.contentWidth * 0.1
	prev.y = display.contentHeight 
	prev:setFillColor( 1, 0.84, 0 )
	sceneGroup:insert( prev )

	prev:addEventListener( "tap", function()
		composer.gotoScene( "pages.fusion", "fade" )
	end )
end

scene:addEventListener( "create", scene )

return scene