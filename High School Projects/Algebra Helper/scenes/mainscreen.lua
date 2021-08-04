-- =============================================================
-- 12DTS Composer Example
-- =============================================================
-- Main Screen
-- =============================================================
local composer 		= require( "composer" )
local scene    		= composer.newScene()
local widget 		= require( "widget" )
----------------------------------------------------------------------
--								LOCALS								--
----------------------------------------------------------------------
-- Constants
local fullw = display.contentWidth
local fullh = display.contentHeight
local centerX = display.contentCenterX
local centerY = display.contentCenterY

----------------------------------------------------------------------
--	Scene Methods
----------------------------------------------------------------------

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:create( event )

	local sceneGroup = self.view
	-- Place all your code in this section.
	-- Make sure all display objects eventually end up in the screenGroup.
	----------------------------------------------------------------------
	----------------------------------------------------------------------
	
	display.setDefault("background", 243, 243, 243) -- Set background colour
	
	local titleOptions = 
	{
		text = "Algebra Helper",     
		x = centerX,
		y = 30,
		font = "Merriweather.ttf",   
		fontSize = 24,
		align = "centre"  -- Alignment parameter
	}

	local title = display.newText(titleOptions)
	title:setFillColor(0,0,0)
	sceneGroup:insert(title)

	local underScoreOptions = 
	{
		text = "________",     
		x = centerX,
		y = title.y - 40,
		font = "Merriweather.ttf",   
		fontSize = 24,
		align = "centre"  -- Alignment parameter
	}
	
	local underScore = display.newText(underScoreOptions)
		underScore:setFillColor(0,0,0)
		sceneGroup:insert(underScore)
		
	local underScore2Options = 
	{
		text = "________",     
		x = centerX,
		y = title.y + 15,
		font = "Merriweather.ttf",   
		fontSize = 24,
		align = "centre"  -- Alignment parameter
	}
	
	local underScore2 = display.newText(underScore2Options)
		underScore2:setFillColor(0,0,0)
		sceneGroup:insert(underScore2)
	
	local symbols = display.newImage("symbols.png")
		symbols:translate( centerX, underScore2.y + 35 ) -- Position the image
		symbols:scale(0.75, 0.75) -- Scale the Image smaller to 75%
		sceneGroup:insert(symbols) -- Insert image into sceneGroup
	
	local verticalLine = display.newImage("verticalLine.png")
		verticalLine:translate(centerX - 28, centerY + 10 )
		verticalLine:scale(0.55, 0.55)
		sceneGroup:insert(verticalLine)
		
	local learnIcon = display.newImage("learnIcon.png")
		learnIcon:translate(centerX - 90, centerY - 60)
		learnIcon:scale(0.85, 0.85)
		sceneGroup:insert(learnIcon)
		
	local testIcon = display.newImage("testIcon.png")
		testIcon:translate(centerX - 90, learnIcon.y + 100)
		testIcon:scale(0.85, 0.85)
		sceneGroup:insert(testIcon)
		
	local statisticsIcon = display.newImage("statisticsIcon.png")
		statisticsIcon:translate(centerX - 90, testIcon.y + 100)
		statisticsIcon:scale(0.85, 0.85)
		sceneGroup:insert(statisticsIcon)
	

	-- Function to handle button events
	local function learnHandleButtonEvent(event)
		if ( "ended" == event.phase ) then
			local options = {
					effect = "slideLeft",
					time = 750,
			}	
			composer.gotoScene("scenes.learn", options)			
		end
	end

	-- -- Create the widget
	local learnButton = widget.newButton(
		{
			label = "Learn",
			labelColor = {default={236/255, 236/255, 236/255}, over={ 220/255, 220/255, 220/255}},
			font = "Merriweather.ttf",
			fontSize = 28,
			onEvent = learnHandleButtonEvent,
			-- Properties for a rounded rectangle button
			shape = "roundedRect",
			width = 125,
			height = 80,
			cornerRadius = 8,
			fillColor = {default={74/255, 134/255, 232/255}, over={54/255, 114/255, 210/255}},
			strokeColor = {default={0,0,0,1}, over={0,0,0,1}},
			strokeWidth = 3
		}
	)
	sceneGroup:insert(learnButton)
	-- Center the button
	learnButton.x = learnIcon.x + 150
	learnButton.y = learnIcon.y
	
	
	-- Function to handle button events
	local function testHandleButtonEvent(event)
		if ( "ended" == event.phase ) then
			local options = {
					effect = "slideLeft",
					time = 750,
			}	
			composer.gotoScene( "scenes.test", options )	
		end
	end

	-- -- Create the widget
	local testButton = widget.newButton(
		{
			label = "Test",
			labelColor = {default={236/255, 236/255, 236/255}, over={ 220/255, 220/255, 220/255}},
			font = "Merriweather.ttf",
			fontSize = 28,
			onEvent = testHandleButtonEvent,
			-- Properties for a rounded rectangle button
			shape = "roundedRect",
			width = 125,
			height = 80,
			cornerRadius = 8,
			fillColor = {default={74/255, 134/255, 232/255}, over={54/255, 114/255, 210/255}},
			strokeColor = {default={0,0,0,1}, over={0,0,0,1}},
			strokeWidth = 3
		}
	)
	sceneGroup:insert(testButton)
	-- Center the button
	testButton.x = testIcon.x + 150
	testButton.y = testIcon.y
	
	
	-- Function to handle button events
	local function statisticsHandleButtonEvent( event )
		if ( "ended" == event.phase ) then
			local options = {
					effect = "slideLeft",
					time = 750,
			}	
			composer.gotoScene("scenes.statistics", options)	
		end
	end

	-- Create the widget
	local statisticsButton = widget.newButton(
		{
			label = "Statistics",
			labelColor = {default={236/255, 236/255, 236/255}, over={ 220/255, 220/255, 220/255}},
			font = "Merriweather.ttf",
			fontSize = 24,
			onEvent = statisticsHandleButtonEvent,
			-- Properties for a rounded rectangle button
			shape = "roundedRect",
			width = 125,
			height = 80,
			cornerRadius = 8,
			fillColor = {default={74/255, 134/255, 232/255}, over={54/255, 114/255, 210/255}},
			strokeColor = {default={0,0,0,1}, over={0,0,0,1}},
			strokeWidth = 3
		}
	)
	sceneGroup:insert(statisticsButton)
	-- Center the button
	statisticsButton.x = statisticsIcon.x + 150
	statisticsButton.y = statisticsIcon.y
	
	
	
		-- Function to handle button events
	local function aboutHandleButtonEvent(event)
		if ( "ended" == event.phase ) then
			composer.gotoScene("scenes.about")
		end
	 end
	 
	local aboutButton = widget.newButton(
		{
			width = 110,
			height = 50,
			defaultFile = "about.png",
			overFile = "about2.png",
			onEvent = aboutHandleButtonEvent
		}
	)
		sceneGroup:insert(aboutButton)
		-- Center the button
		aboutButton.x = centerX
		aboutButton.y = centerY + 245
	
end

---------------------------------------------------------------------------------
-- Generally Do Not Touch Below This Line
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
