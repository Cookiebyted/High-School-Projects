-- =============================================================
-- Written by Craig Briggs.  Feel free to modify and reuse in anyway.
--
-- gameScene.lua
-- Creates the game enviroment
-- =============================================================
local composer 		= require( "composer" )
local scene    		= composer.newScene()
local widget 		= require( "widget" )

----------------------------------------------------------------------
--							Requires								--
----------------------------------------------------------------------
local Game			= require ("Classes.Game")
local pt = require("Classes.printTable")
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
function scene:create( event )
	local sceneGroup = self.view
	
	-- options table for game
	local options = { 
		enemyDetails = {
			startSpeed = 10,  -- start speed for the enemies
			speedModifer = 1.1, -- amount it increases the speed by
			maxSpeed = 80, -- max speed for enemies, stops them going crazy
			wallHitCount = 1, -- number of times it will collise with the wall before it drops
			dropAmount = 10, -- how much it will drop by each time it reaches wallHitCount	
			bombSpeed = 200, -- speed at which bombs drop
			bombIntervalMin = 1000, -- minumim time between bomb drops (indivdual enemy)
			bombIntervalMax = 10000 -- maximum time between bomb drops (indivdual enemy)
			
		},
		playerDetails = {
			playerSpeed = 120, -- speed player moves across the screen
			bulletSpeed = 200, -- speed bullets fire up the screen
			bulletInterval = 600, -- interval between bullets
		}
	}
	
	-- call the the main game class and pass over the options table
	local Game = Game:new(sceneGroup, options)
	Game:setUp() -- set up game
	Game:startGame() -- start the game
	Game:listen() -- set game to listen for events
	
	-- listen for a gameOver, if there is a game over then goto gameOver scene
	sceneGroup.gameOver = function(target, self)
		local options = {
			effect = "fade",
			time = 800,
		}
		composer.gotoScene( "scenes.gameOver", options )	
	end
	
	Runtime:addEventListener("gameOver",sceneGroup) 
	
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
	end
end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:willExit( event )
	local sceneGroup = self.view
	-- remove the listener for gameOver when the scene is about to transition away
	Runtime:removeEventListener("gameOver",sceneGroup) 
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
