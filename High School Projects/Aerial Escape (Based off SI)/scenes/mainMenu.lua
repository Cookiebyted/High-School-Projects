-- =============================================================
-- Written by Craig Briggs.  Feel free to modify and reuse in anyway.
--
-- mainMenu.lua
-- Main menu the user will be presented with
-- =============================================================

----------------------------------------------------------------------
--							Requires								--
----------------------------------------------------------------------
local composer 		= require( "composer" )
local scene    		= composer.newScene()
local widget 		= require( "widget" )
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Constants
local fullw = display.contentWidth
local fullh = display.contentHeight
local centerX = display.contentCenterX
local centerY = display.contentCenterY

----------------------------------------------------------------------
--	Scene Methods
----------------------------------------------------------------------
function scene:create( event )
	local sceneGroup = self.view

	local function createTextBox()
		local title = display.newText(sceneGroup, "Aerial Escape", centerX, centerY - 130, native.systemFont, 36)
		title:setFillColor(1,1,1)

		local enterPlayerNameText = display.newText("Enter Player Name", centerX, centerY - 50, native.systemFont, 24)
		enterPlayerNameText:setFillColor(1, 1, 1)
		sceneGroup:insert(enterPlayerNameText)

		textField = native.newTextField(0, 0, 175, 30)
		textField.x = centerX
		textField.y = enterPlayerNameText.y + 35
		sceneGroup:insert(textField)

		return textField
	end

	local function selectButton()
		local maxLimit = 12

		local function handleButtonEvent(event)
			if textField.text == "" then
				local alert = native.showAlert( "Error", "Please Enter a Name", {"OK"} )
			elseif string.len(textField.text) > maxLimit then
				local alert = native.showAlert( "Error", "Too Long Name", {"OK"} )
			else composer.gotoScene("scenes.gameScene")
			end
		end
	
		local changeSceneButton = widget.newButton(
			{
				label = "Play Game",
				onEvent = handleButtonEvent,
				emboss = false,
				-- Properties for a rounded rectangle button
				shape = "roundedRect",
				width = 200,
				height = 40,
				cornerRadius = 2,
				fillColor = { default={2,2,0,1}, over={1,0.1,0.7,0.4} },
				strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
				strokeWidth = 4
			})
		changeSceneButton.x = centerX
		changeSceneButton.y = centerY + 80
		sceneGroup:insert(changeSceneButton)
	end
	createTextBox()
	selectButton()
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
	
	-- remove the previous scene,  so that when it is reloaded it starts fresh
	local prevScene = composer.getSceneName( "previous" )
	if prevScene then
		composer.removeScene( prevScene, true ) 
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
