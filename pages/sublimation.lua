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

  
  local sublimationSheetOptions = {
    width = 334,
    height = 171,
    numFrames = 46
  }
  sublimation = graphics.newImageSheet( utils.sublimation.sublimation, sublimationSheetOptions )
  local sequenceData = {
  { name = "normal", start = 1, count = 46, time = 5000, loopCount = 0 }
  }
  sublimation = display.newSprite( sublimation, sequenceData )
  sublimation.x = display.contentWidth * 0.5
  sublimation.y = display.contentHeight * 0.6
  sublimation:scale( 2, 2 )
  sceneGroup:insert( sublimation )
  sublimation:play()

  local next = display.newText( utils.next, 0, 0, utils.font, 40 )
	next.x = display.contentWidth * 0.9
	next.y = display.contentHeight 
	next:setFillColor( 1, 0.84, 0 )
	sceneGroup:insert( next )

	next:addEventListener( "tap", function()
		composer.gotoScene( "pages.about", "fade" )
	end )

	local prev = display.newText( utils.prev, 0, 0, utils.font, 40 )
	prev.x = display.contentWidth * 0.1
	prev.y = display.contentHeight 
	prev:setFillColor( 1, 0.84, 0 )
	sceneGroup:insert( prev )

	prev:addEventListener( "tap", function()
		composer.gotoScene( "pages.boiling", "fade" )
	end )
end

scene:addEventListener( "create", scene )

return scene