local utils = require("utils")
local composer = require( "composer" )
local scene = composer.newScene()
local physics = require("physics")
local widget = require( "widget" )

physics.start()

function scene:create( event )
	local sceneGroup = self.view

	local pastForce = 0

	local temperature = display.newText("Temperatura: 0 ºC", 0, 0, utils.font, 40 )
	temperature.x = display.contentWidth * 0.5
	temperature.y = display.contentHeight * 0.75
	sceneGroup:insert( temperature )

	for i = 1, #utils.atomsDescription do
		local text = display.newText(utils.atomsDescription[i], 0, 0, utils.font, 40 )
		text.x = display.contentWidth * 0.5
		text.y = i * 50
		sceneGroup:insert( text )
	end

	local wallTop = display.newLine( 0, 0, display.contentWidth * 0.5, 0 )
	wallTop.x = display.contentWidth * 0.25
	wallTop.y = display.contentHeight * 0.3
	wallTop.strokeWidth = 3
	wallTop:setStrokeColor( 1, 1, 1 )
	sceneGroup:insert( wallTop )
	physics.addBody( wallTop, "static", { friction = 0.5 } )

    local wallBottom = display.newLine( 0, 0, display.contentWidth * 0.5, 0 )
	wallBottom.x = display.contentWidth * 0.25
	wallBottom.y = display.contentHeight * 0.5
	wallBottom.strokeWidth = 3
	wallBottom:setStrokeColor( 1, 1, 1 )
	sceneGroup:insert( wallBottom )
	physics.addBody( wallBottom, "static", { friction = 0.5 } )

    local wallLeft = display.newLine( 0, 0, 0, display.contentHeight * 0.2 )
	wallLeft.x = display.contentWidth * 0.25
	wallLeft.y = display.contentHeight * 0.3
	wallLeft.strokeWidth = 3
	wallLeft:setStrokeColor( 1, 1, 1 )
	sceneGroup:insert( wallLeft )
	physics.addBody( wallLeft, "static", { friction = 0.5 } )

	local wallRight = display.newLine( 0, 0, 0, display.contentHeight * 0.2 )
	wallRight.x = display.contentWidth * 0.75
	wallRight.y = display.contentHeight * 0.3
	wallRight.strokeWidth = 3
	wallRight:setStrokeColor( 1, 1, 1 )
	sceneGroup:insert( wallRight )
	physics.addBody( wallRight, "static", { friction = 0 } )
	
	local atoms = {}
	for i = 1, 10 do
		atoms[i] = display.newCircle( 0, 0, 25 )
		atoms[i].x = display.contentWidth * 0.3
		atoms[i].y = display.contentHeight * 0.4
		atoms[i].fill = utils.gradient
		sceneGroup:insert( atoms[i] )
		physics.addBody( atoms[i], "static", { friction = 0.5, bounce = 1 } )
		atoms[i]:applyForce( 1, 1, atoms[i].x, atoms[i].y )
	end

	local sliderThermometer = widget.newSlider
	{
		x = display.contentWidth * 0.5,
		y = display.contentHeight * 0.85,
		width = display.contentWidth * 0.7,
		value = 0.5,
		listener = function( event )
			local phase = event.phase
			if phase == "moved" then
				local value = event.value
				local temp = math.floor( value  )
				temperature.text = "Temperatura: " .. temp .. " ºC"
				for i = 1, #atoms do
					if pastForce > temp then
						atoms[i]:setLinearVelocity( 0, 0 )
					else
						atoms[i]:applyForce( 50, 50, atoms[i].x, atoms[i].y )
					end
					pastForce = temp
				end
			end
		end
	}
	sceneGroup:insert( sliderThermometer )

	local next = display.newText( utils.next, 0, 0, utils.font, 40 )
	next.x = display.contentWidth * 0.9
	next.y = display.contentHeight
	next:setFillColor( 1, 0.84, 0 )
	sceneGroup:insert( next )

	next:addEventListener( "tap", function()
		composer.gotoScene( "pages.solidification" )
	end )

	local prev = display.newText( utils.prev, 0, 0, utils.font, 40 )
	prev.x = display.contentWidth * 0.1
	prev.y = display.contentHeight
	prev:setFillColor( 1, 0.84, 0 )
	sceneGroup:insert( prev )

	prev:addEventListener( "tap", function()
		composer.gotoScene( "pages.physical-states" )
	end )
end

scene:addEventListener( "create", scene )

return scene