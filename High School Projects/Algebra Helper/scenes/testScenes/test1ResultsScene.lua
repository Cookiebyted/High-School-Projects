-- =============================================================
-- 12DTS Composer Example
-- =============================================================
-- Statistics
-- =============================================================
local composer 		= require( "composer" )
local scene    		= composer.newScene()
local widget 		= require( "widget" )
local questionsM 	= require ("scripts.questionList")
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
	
	print(#questionsM.results)
	for i =  1, #questionsM.results do
		local text = display.newText(sceneGroup, "Question " ..i .." = " .. questionsM.results[i], centerX, 30 + i * 50, nil, 24)
			text:setFillColor( 1, 0, 0 )
	end
 
	local function handleButtonEvent(event)
		if ( "ended" == event.phase ) then
			local options =
			{
				effect = "fade",
				time = 200
			}
			composer.gotoScene( "scenes.test", options)	
		end
	end

	-- Create the button
	local button1 = widget.newButton(
		{
			label = "Finish",
			onEvent = handleButtonEvent,
			emboss = false,
			-- Properties for a rounded rectangle button
			shape = "roundedRect",
			width = fullw * .8,
			height = 40,
			cornerRadius = 2,
			fillColor = {default={207/255,226/255,243/255}, over={187/255, 226/255,243/255}},
			strokeColor = { default={0,0,0,1}, over={0,0,0,1} },
			strokeWidth = 2
		}
	)
	sceneGroup:insert(button1)
	-- Center the button
	button1.x = centerX
	button1.y = centerY + 100
	
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
