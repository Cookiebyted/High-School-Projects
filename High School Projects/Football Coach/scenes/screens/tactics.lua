-- =============================================================
-- Tactics.lua
-- =============================================================
----------------------------------------------------------------------
--								LOCALS								--
----------------------------------------------------------------------
local composer 		= require( "composer" )
local scene    		= composer.newScene()
local widget 		= require( "widget" )

-- Constants
local fullw, fullh = display.contentWidth, display.contentHeight
local centerX, centerY = display.contentCenterX, display.contentCenterY

----------------------------------------------------------------------
--	Scene Methods
----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:create( event )
	local sceneGroup = self.view

	physics.start()

	local tutorial = timer.performWithDelay(1000, function() native.showAlert("How To Use Tactics Board", "Click on buttons to add objects. If you wish to remove objects then simply drag it off the screen.", {"OK"}) end)

	local pitch = display.newImage(sceneGroup, "images/pitch.png", centerX, centerY)
	pitch:scale(0.3,0.3)

	local topBar = display.newRect(sceneGroup, centerX, centerY - 260, fullw + 5, 50)
	topBar:setFillColor(224/255,102/255,102/255)
	topBar.strokeWidth = 3
	topBar:setStrokeColor(0, 0, 0)
	
	local title = display.newText(sceneGroup, "Tactics Board", centerX , topBar.y, native.systemFontBold, 24)
	title:setFillColor(0,0,0)

	local function handleButtonEvent( event )
		if ( "ended" == event.phase ) then
			print( "Button was pressed and released" )
			local options = {
				effect = "slideRight",
				time = 750
			}
			composer.gotoScene("scenes.home", options)	
		end
	end
	
	-- -- Create the widget
	local backHomeScreen = widget.newButton(
		{
			onEvent = handleButtonEvent,
			width = 32,
			height = 32,
			defaultFile = "images/arrow.png",
		})
	sceneGroup:insert(backHomeScreen)
	-- Center the button
	backHomeScreen.x = topBar.x - 135
	backHomeScreen.y = topBar.y

	local function footballHandleButtonEvent( event )
		if ( "ended" == event.phase ) then
			print("FOOTBALL")
			local football = display.newImageRect(sceneGroup, "images/drills.png", 20, 20)
				football.x = centerX
				football.y = centerY + 31

			local function dragObject( event )
				if (event.phase == "moved") then
					football.x = event.x
					football.y = event.y
					if football.x < -6 or football.x > fullw + 6 or football.y < 45 or football.y > fullh + 50 then
						football:removeSelf()
						print("REMOVED")
					end
				end
			end
			football:addEventListener("touch", dragObject) -- Make object draggable
		end
	end
	
	-- Create the widget
	local football = widget.newButton(
		{
			onEvent = footballHandleButtonEvent,
			width = 20,
			height = 20,
			defaultFile = "images/drills.png",
		})
	sceneGroup:insert(football)
	-- Center the button
	football.x = centerX - 30
	football.y = topBar.y + 43

	local function blueHandleButtonEvent( event )
		if ( "ended" == event.phase ) then
			print("FOOTBALL")
			local blue = display.newImageRect(sceneGroup, "images/blue.png", 20, 20)
				blue.x = centerX
				blue.y = centerY + 31

			local function dragObject( event )
				if (event.phase == "moved") then
					blue.x = event.x
					blue.y = event.y
					if blue.x < -6 or blue.x > fullw + 6 or blue.y < 45 or blue.y > fullh + 50 then
						blue:removeSelf()
						print("REMOVED")
					end
				end
			end
			blue:addEventListener("touch", dragObject) -- make object draggable
		end
	end
	
	-- Create the widget
	local blue = widget.newButton(
		{
			onEvent = blueHandleButtonEvent,
			width = 20,
			height = 20,
			defaultFile = "images/blue.png",
		})
	sceneGroup:insert(blue)
	-- Center the button
	blue.x = football.x + 30
	blue.y = football.y

	local function redHandleButtonEvent( event )
		if ( "ended" == event.phase ) then
			print("FOOTBALL")
			local red = display.newImageRect("images/red.png", 20, 20)
				red.x = centerX
				red.y = centerY + 31
				sceneGroup:insert(red)

			local function dragObject( event )
				if (event.phase == "moved") then
					red.x = event.x
					red.y = event.y
					if red.x < -6 or red.x > fullw + 6 or red.y < 45 or red.y > fullh + 50 then
						red:removeSelf()
						print("REMOVED")
					end
				end
			end
			red:addEventListener("touch", dragObject) -- make object draggable
		end
	end
	
	-- Create the widget
	local red = widget.newButton(
		{
			onEvent = redHandleButtonEvent,
			width = 20,
			height = 20,
			defaultFile = "images/red.png",
		})
	sceneGroup:insert(red)
	-- Center the button
	red.x = football.x + 60
	red.y = football.y




	
end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:willEnter( event )
	local sceneGroup = self.view
end
----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:didEnter( event )
	local sceneGroup = self.view
	local prevScene = composer.getSceneName( "previous" )
	if prevScene then
		composer.removeScene( prevScene, true ) 
		print("removing ", prevScene)
	end
end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:willExit( event )
	local sceneGroup = self.view
end
----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:didExit( event )
	local sceneGroup = self.view
end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:destroy( event )
	local sceneGroup = self.view
end

----------------------------------------------------------------------
--				FUNCTION/CALLBACK DEFINITIONS						--
----------------------------------------------------------------------

---------------------------------------------------------------------------------
-- Scene Dispatch Events, Etc. - Generally Do Not Touch Below This Line
---------------------------------------------------------------------------------
function scene:show( event )
	local sceneGroup 	= self.view
	local willDid 	= event.phase
	if( willDid == "will" ) then
		self:willEnter( event )
	elseif( willDid == "did" ) then
		self:didEnter( event )
	end
end
function scene:hide( event )
	local sceneGroup 	= self.view
	local willDid 	= event.phase
	if( willDid == "will" ) then
		self:willExit( event )
	elseif( willDid == "did" ) then
		self:didExit( event )
	end
end
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
---------------------------------------------------------------------------------
return scene
