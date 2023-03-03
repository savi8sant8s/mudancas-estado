local utils = require("utils")
local composer = require( "composer" )
local scene = composer.newScene()
local physics = require("physics")
local widget = require( "widget" )

local function getGradientTemperatureColor(temperature)
	local r = 0
	local g = 0
	local b = 0
	if temperature < 5 then
		r = 0
		g = 0
		b = 0.5
	elseif temperature < 20 then
		r = 0
		g = 0.5
		b = 1
	elseif temperature < 30 then
		r = 0
		g = 0.7
		b = 0.7
	elseif temperature < 60 then
		r = 1
		g = 1
		b = 0
	elseif temperature < 80 then
		r = 1
		g = 0.5
		b = 0
	elseif temperature < 100 then
		r = 1
		g = 0
		b = 0
	else
		r = 0.5
		g = 0
		b = 0
	end
	return {
		type = "gradient",
		color1 = { r, g, b, 1 },
		color2 = { r, g, b, 0.5 },
		direction = "down"
	}
end
	
function scene:create( event )
	local sceneGroup = self.view
	physics.start()
	physics.setGravity(0, 0)

	local temperature = display.newText("Temperatura: 0 ºC", 0, 0, utils.font, 50 )
	temperature.x = display.contentWidth * 0.5
	temperature.y = display.contentHeight * 0.65
	sceneGroup:insert( temperature )

	for i = 1, #utils.molecules.description do
		local text = display.newText(utils.molecules.description[i], 0, 0, utils.font, 50 )
		text.x = display.contentWidth * 0.5
        text.y = i * 50
        sceneGroup:insert( text )
	end

	local wallTop = display.newLine( 0, 0, display.contentWidth * 0.6, 0 )
	wallTop.x = display.contentWidth * 0.2
	wallTop.y = display.contentHeight * 0.3
	wallTop.strokeWidth = 3
	wallTop:setStrokeColor( 1, 1, 1 )
	sceneGroup:insert( wallTop )
	physics.addBody( wallTop, "static", { friction = 0.5 } )

    local wallBottom = display.newLine( 0, 0, display.contentWidth * 0.6, 0 )
	wallBottom.x = display.contentWidth * 0.2
	wallBottom.y = display.contentHeight * 0.5
	wallBottom.strokeWidth = 3
	wallBottom:setStrokeColor( 1, 1, 1 )
	sceneGroup:insert( wallBottom )
	physics.addBody( wallBottom, "static", { friction = 0.5 } )

    local wallLeft = display.newLine( 0, 0, 0, display.contentHeight * 0.2 )
	wallLeft.x = display.contentWidth * 0.2
	wallLeft.y = display.contentHeight * 0.3
	wallLeft.strokeWidth = 3
	wallLeft:setStrokeColor( 1, 1, 1 )
	sceneGroup:insert( wallLeft )
	physics.addBody( wallLeft, "static", { friction = 0.5 } )

	local wallRight = display.newLine( 0, 0, 0, display.contentHeight * 0.2 )
	wallRight.x = display.contentWidth * 0.8
	wallRight.y = display.contentHeight * 0.3
	wallRight.strokeWidth = 3
	wallRight:setStrokeColor( 1, 1, 1 )
	sceneGroup:insert( wallRight )
	physics.addBody( wallRight, "static", { friction = 0 } )
	
	local molecules = {}
	for i = 1, 20 do
		molecules[i] = display.newCircle( 0, 0, 25 )
		molecules[i].x = display.contentWidth * 0.3 + math.random( 0, 200 )
		molecules[i].y = display.contentHeight * 0.4 + math.random( 0, 100 )
		molecules[i].fill = getGradientTemperatureColor(0)
		sceneGroup:insert( molecules[i] )
		physics.addBody( molecules[i], "dynamic", { friction = 0, radius = 25, bounce = 1 } )
	end

	local sliderThermometer = widget.newSlider
	{
		x = display.contentWidth * 0.5,
		y = display.contentHeight * 0.7,
		width = display.contentWidth * 0.7,
		value = 0.5,
		listener = function( event )
			local phase = event.phase
			if phase == "moved" then
				local value = event.value
				local temp = math.floor( value  )
				temperature.text = "Temperatura: " .. temp .. " ºC"
				for i = 1, #molecules do
					molecules[i].fill = getGradientTemperatureColor( temp )
					molecules[i]:setLinearVelocity( temp * 10 , temp * 10 )
				end
			end
		end
	}
	sceneGroup:insert( sliderThermometer )

	local rectBorder = display.newRect( 0, 0, display.contentWidth * 0.7, display.contentHeight * 0.125 )
    rectBorder.x = display.contentWidth * 0.5
    rectBorder.y = display.contentHeight * 0.825
    rectBorder.strokeWidth = 4
    rectBorder:setFillColor( 0, 0, 0, 0 )
    rectBorder:setStrokeColor( 1, 1, 1 )
    sceneGroup:insert( rectBorder )
	
	for i = 1, #utils.molecules.tip do
        local text = display.newText(utils.molecules.tip[i], 0, 0, utils.font, 40 )
        text.x = display.contentWidth * 0.5
        text.y = display.contentHeight * 0.75 + i * 50
        sceneGroup:insert( text )
    end
	
	local next = display.newText( utils.next, 0, 0, utils.font, 40 )
	next.x = display.contentWidth * 0.9
	next.y = display.contentHeight
	next:setFillColor( 1, 0.84, 0 )
	sceneGroup:insert( next )

	next:addEventListener( "tap", function()
		composer.gotoScene( "pages.solidification", "fade" )
	end )

	local prev = display.newText( utils.prev, 0, 0, utils.font, 40 )
	prev.x = display.contentWidth * 0.1
	prev.y = display.contentHeight
	prev:setFillColor( 1, 0.84, 0 )
	sceneGroup:insert( prev )

	prev:addEventListener( "tap", function()
		composer.gotoScene( "pages.physical-states", "fade" )
	end )
end

scene:addEventListener( "create", scene )

return scene