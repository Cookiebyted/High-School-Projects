-- =============================================================
-- 12DTS Composer Example
-- =============================================================
-- Statistics
-- =============================================================
local composer 		= require( "composer" )
local scene    		= composer.newScene()
local widget 		= require( "widget" )
local questionsM	= require ("scripts.questionList")
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
	local secondBar = display.newRect(centerX, centerY - 220, fullw + 5, 30)
		secondBar:setFillColor(141/255, 183/255, 250/255)
		secondBar.strokeWidth = 3
		secondBar:setStrokeColor(0, 0, 0 )
		sceneGroup:insert(secondBar)
	
	
	local topBar = display.newRect(centerX, centerY - 260, fullw + 5, 50)
		topBar:setFillColor(74/255,134/255,232/255)
		topBar.strokeWidth = 3
		topBar:setStrokeColor(0, 0, 0 )
		sceneGroup:insert(topBar)
	
		
	local title = display.newText("Statistics", centerX, secondBar.y + 50, "Merriweather.ttf", 26)
	title:setFillColor(0,0,0)
	sceneGroup:insert(title)
	
	local underScoreOptions = 
	{
		text = "________",     
		x = centerX,
		y = title.y - 32,
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
		y = title.y + 8,
		font = "Merriweather.ttf",   
		fontSize = 24,
		align = "centre"  -- Alignment parameter
	}
	
	local underScore2 = display.newText(underScore2Options)
		underScore2:setFillColor(0,0,0)
		sceneGroup:insert(underScore2)
	
	
	-- -- Function to handle button events
	local function handleButtonEvent( event )
		if ( "ended" == event.phase ) then
			print( "Button was pressed and released" )
			local options = {
				effect = "slideRight",
				time = 750
			}
			composer.gotoScene("scenes.mainscreen", options)	
		end
	end
	
	-- -- Create the widget
	local backHomeScreen = widget.newButton(
		{
			label = "Back",
			labelColor = {default={0,0,0,1}, over={0,0,0,1}},
			onEvent = handleButtonEvent,
			-- Properties for a rounded rectangle button
			shape = "roundedRect",
			width = 72,
			height = 20,
			cornerRadius = 2,
			fillColor = {default={207/255,226/255,243/255}, over={187/255, 226/255,243/255}},
			strokeColor = { default={0,0,0,1}, over={0,0,0,1} },
			strokeWidth = 1
		}
	)
	sceneGroup:insert(backHomeScreen)
	-- Center the button
	backHomeScreen.x = secondBar.x - 115
	backHomeScreen.y = secondBar.y + 1
	
		table.print_r(questionsM)
	local correct = 0
	local incorrect = 0
	for i = 1, #questionsM.results do 
		if questionsM.results[i] == "Correct" then
			correct = correct + 1
	end
	incorrect = #questionsM.results - correct
		
		local statsOptions = 
	{
		text = correct .. " Correct",
		x = 100,
		y = 200,
		width = 128,
		font = "Merriweather.ttf",   
		fontSize = 18,
		align = "right"  -- Alignment parameter
	}
	 
	local statsText = display.newText(statsOptions)
	statsText:setFillColor( 1, 0, 0 )
	sceneGroup:insert(statsText)
	
	local stats2Options = 
	{
		text = incorrect .. " Incorrect",
		x = 100,
		y = 300,
		width = 128,
		font = native.systemFont,   
		fontSize = 18,
		align = "right"  -- Alignment parameter
	}
	 
	local statsText2 = display.newText(stats2Options)
	statsText2:setFillColor( 1, 0, 0 )
 end
	
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
