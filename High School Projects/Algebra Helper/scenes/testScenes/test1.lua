-- =============================================================
-- 12DTS Composer Example
-- =============================================================
-- Test
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
function scene:create(event)

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
	
	local myText = display.newText( "Inequalities", centerX, secondBar.y + 50, "Merriweather.ttf", 16 )
	myText:setFillColor( 0, 0, 0 )
	sceneGroup:insert(myText)
	
	
	 -- Function to handle button events
	local function handleButtonEvent( event )
		if ( "ended" == event.phase ) then
			questionsM.currentQuestion = "maths"
			
			local function shuffleTable(t)
				-- t = table to be shuffled
				local rand = math.random 
				assert( t, "shuffleTable() expected a table, got nil" )
				local iterations = #t
				local j
				
				for i = iterations, 2, -1 do
					j = rand(i)
					t[i], t[j] = t[j], t[i]
				end
			end
			
			-- 4 possible answers
			local answerTable = {}
			for i = 1, #questionsM.quizQuestions[questionsM.currentQuestion] do
				answerTable[i] = i
			end
			-- shuffle the table so that the numbers are in a random order
			shuffleTable(answerTable)
			
			questionsM.answerTable = answerTable
			
			questionsM.results = {} -- to record the users results i.e. 1 attempt or 4 attempts etc
			
			local options = {
				effect = "slideUp",
				time = 750
			}
			composer.gotoScene("scenes.testScenes.test1QuestionScene", options)	
		end
	end

	-- Create button widget
	local startTestButton = widget.newButton(
		{
			label = "Start Test",
			labelColor = {default={0,0,0,1}, over={0,0,0,1}},
			onEvent = handleButtonEvent,
			-- Properties for a rounded rectangle button
			shape = "roundedRect",
			width = 86,
			height = 20,
			cornerRadius = 2,
			fillColor = {default={207/255,226/255,243/255}, over={187/255, 226/255,243/255}},
			strokeColor = { default={0,0,0,1}, over={0,0,0,1} },
			strokeWidth = 1
		}
	)
	sceneGroup:insert(startTestButton)
	-- Center the button
	startTestButton.x = centerX + 100
	startTestButton.y = centerY
	
	
	 -- Function to handle button events
	local function backHandleButtonEvent(event)
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
			onEvent = backHandleButtonEvent,
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
	
	
	 -- Function to handle button events
	local function testHandleButtonEvent(event)
		if ( "ended" == event.phase ) then
			print( "Button was pressed and released" )
			local options = {
				effect = "slideRight",
				time = 750
			}
			composer.gotoScene("scenes.learnScenes.learn1", options)	
		end
	end

	-- -- Create the widget
	local learnButton = widget.newButton(
		{
			label = "Learn",
			labelColor = {default={0,0,0,1}, over={0,0,0,1}},
			onEvent = testHandleButtonEvent,
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
	sceneGroup:insert(learnButton)
	-- Center the button
	learnButton.x = centerX - 100
	learnButton.y = centerY
	
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
