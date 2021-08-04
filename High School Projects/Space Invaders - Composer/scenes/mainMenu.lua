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

	-- Write title on the screen
	
	local options = 
	{
		parent = sceneGroup,
		text = "Space Invaders",     
		x = centerX,
		y = 80,
		width = fullw,
		font = native.systemFont,   
		fontSize = 56,
		align = "center"  -- Alignment parameter
	}
 
	local title = display.newText( options )
	title:setFillColor(0,1,0)
	
	-- create a button to start the game when pressed
	local function handleButtonEvent( event )
		if ( "ended" == event.phase ) then
			local options = {
				effect = "fade",
				time = 800
			}
			composer.gotoScene( "scenes.gameScene", options )
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
			fillColor = { default={1,1,0,1}, over={1,0.1,0.7,0.4} },
			strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
			strokeWidth = 4
		}
	)
	sceneGroup:insert(changeSceneButton)
	-- Center the button
	changeSceneButton.x = centerX
	changeSceneButton.y = fullh - 100

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
