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
--	Functions
----------------------------------------------------------------------

-- Seed randoms to make more random
math.randomseed(os.time())

-- Shuffle the table that is passed over
local function shuffleTable(t)
	-- "t" = table to be shuffled
	local rand = math.random
	assert(t, "shuffleTable() expected a table, got nil")
	local iterations = #t
	local j
	
	for i = iterations, 2, -1 do
		j = rand(i)
		t[i], t[j] = t[j], t[i]
	end
end

-- Create the Test Buttons
local function createButton(sceneGroup, text, yLocation, id)
	-- sceneGroup - group to insert button into
	-- text - text to display
	-- ylocation - location of button
	-- id - number of question (1 - 4)
	
	local function handleButtonEvent(event)
		local target = event.target

		if ("ended" == event.phase) then
		questionsM.attempts = questionsM.attempts + 1
		-- If number is 1 then it is correct
			if event.target.id == 1 then
				print("Correct Answer.")
				target:setFillColor(40/255, 1, 0)
				-- Writes an entry to the next results table with the number of attempts
				questionsM.results[#questionsM.results + 1] = "Correct"
				
			else
				-- or other situations it is false
				questionsM.results[#questionsM.results + 1] = "Incorrect"
				print("incorrect answer")
				target:setFillColor(255, 0, 0)
			end
			if #questionsM.answerTable > 0 then
				
				-- if the correct answer is pressed, then goto returnScene and come back to next question
				local options =
				{
					effect = "fade",
					time = 400
				}
				composer.gotoScene("scenes.testScenes.test1ReturnScene", options)	
			else
				local options =
				{
					effect = "fade",
					time = 400
				}
				composer.gotoScene( "scenes.testScenes.test1ResultsScene", options )	
			end
		end
	end

	-- Create button widget
	local button1 = widget.newButton(
		{
			label = text,
			labelColor = {default={0,0,0,1}, over={0,0,0,1}},
			onEvent = handleButtonEvent,
			id = id,
			-- Properties for a rounded rectangle button
			shape = "roundedRect",
			width = fullw * 0.8,
			height = 40,								
			cornerRadius = 2,
			fillColor = {default={207/255,226/255,243/255}, over={187/255, 226/255,243/255}},
			strokeColor = { default={0,0,0,1}, over={0,0,0,1} },
			strokeWidth = 1
		}
	)
	sceneGroup:insert(button1)
	-- Center the button
	button1.x = centerX 
	button1.y = yLocation 

end

----------------------------------------------------------------------
--	Scene Methods
----------------------------------------------------------------------

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:create( event )

	local sceneGroup = self.view
	
	-- Localize information about the current question
	questionsM.attempts = 0  -- Reset the number of times they have tried each time the sscene is loaded
	
	local quizQuestions = questionsM.quizQuestions[questionsM.currentQuestion]

	local currentQuestionNumber = questionsM.answerTable[#questionsM.answerTable]
	questionsM.answerTable[#questionsM.answerTable] = nil
	
	local currentQuestion = quizQuestions[currentQuestionNumber].question
	local currentAnswers = quizQuestions[currentQuestionNumber].answers
	
	-- Display questions
	local options =
	{
		parent = sceneGroup,
		text = currentQuestion,
		x = centerX,
		y = 180,
		width = fullw * 0.9,
		font = "Merriweather.ttf",
		fontSize = 28,
		align = "center"
	}
	
	local title = display.newText(options)
		title:setFillColor(0)
	
	-- 4 possible answers
	local questions = {1,2,3,4}
	-- Shuffle the table so the numbers are in a random order
	shuffleTable(questions)
	
	for i = 1, #currentAnswers do
		-- Find the last entry in that table
		local currentQuestionNumber = questions[#questions]
		-- Creating the table
		createButton(sceneGroup, currentAnswers[currentQuestionNumber], 200 + (i * 60), currentQuestionNumber)
		-- Delete the last entry 
		questions[#questions] = nil
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
