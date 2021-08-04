-- =============================================================
-- Written by Matthew Young.
--
-- Game.lua
-- Main game class ~ creates the environment and communicates between classes
-- =============================================================

--======================================================================--
--== Game Class factory
--======================================================================--
local Game = class() -- define Game as a class (notice the capitals)
Game.__name = "Game" -- give the class a name
--======================================================================--
--== Require dependant classes
--======================================================================--
local composer 				= require("composer") 
local ControlsClass	 		= require ("Classes.Controls")
local EnemyControllerClass	= require ("Classes.EnemyController")
local PlayerClass 			= require ("Classes.Player")
local ScoreClass			= require ("Classes.Score")
local EnemyClass 			= require ("Classes.Enemy")

-- Constants
local fullw = display.contentWidth
local fullh = display.contentHeight
local centerX = display.contentCenterX
local centerY = display.contentCenterY
--======================================================================--
--== Initialization / Constructor
--======================================================================--
function Game:__init(group)
	-- Constructor for class
	-- Parameters:
	--		group - the group where the game should be inserted into
	-- Returns:
	--		Reference to instance of class
	self.group = group -- the group where the game should be inserted into
end

--======================================================================--
--== Code / Methods
--======================================================================--
function Game:setUp()
	-- Set up the game environment
		-- Draw scrolling background
		-- Create score and start listeners
		-- Create & Draw the Controls on screen
		-- Create and start the Enemy Controller
		-- Create the player and start listeners
		-- Call deconstructor method 

	self:createScrollingBackground()

	local score = ScoreClass:new(self.group, centerX, -20, 28)
	score:drawScore()
	score:listen()

	local leftKey = ControlsClass:new(self.group, 30, fullh + 18, "images/up.png", -90, "left")
	local rightKey = ControlsClass:new(self.group, fullw-30 ,fullh + 18, "images/up.png", 90, "right")
	local spaceKey = ControlsClass:new(self.group, centerX,fullh + 18, "images/space.png", 0, "space")
	local upKey = ControlsClass:new(self.group, 100,fullh + 18, "images/up.png", 0, "up")
	local downKey = ControlsClass:new(self.group, 220, fullh + 18, "images/up.png", 180, "down")

	local enemyController = EnemyControllerClass:new(self.group)
	enemyController:spawnEnemies()

	-- Draw the player
	local player = PlayerClass:new(self.group, centerX, fullh - 50, 3, 700, "player")
	player:draw()
	player:listen()
	  
	self:deconstructor()
end  

function Game:createScrollingBackground()
	-- Display Two Images and loop it scrolling infinitely
	bg1 = display.newImage(self.group, "images/background1.png", centerX, centerY)
 	bg1.x = centerX
 	bg1.y = centerY

	bg2 = display.newImage(self.group, "images/background1.png", centerX, centerY)
 	bg2.x = centerX
 	bg2.y = centerY - fullh

	local scrollSpeed = 4
 
	local function bgScroll (event)
	    if bg1 and bg2 ~= nil then
		    bg1.y = bg1.y + scrollSpeed
		    bg2.y = bg2.y + scrollSpeed
		    if bg1.y == fullh * 1.5 then
		        bg1.y = fullh * -0.5
		    end
		    if bg2.y == fullh * 1.5 then
		        bg2.y = fullh * -0.5
		    end
		else
			bg1 = nil
			bg2 = nil
		end
	end
	Runtime:addEventListener("enterFrame", bgScroll)
end

function Game:listenGameOver()
	-- Listen for gameover event
	function self.gameOver (self, event) -- if a key is pressed
		local options = {
			effect = "fade",
			time = 800,
		}
		composer.gotoScene("scenes.gameOver", options)
	end
	Runtime:addEventListener("gameOver", self)
end

function Game:deconstructor() 
	self.group.finalize = function()
		-- A finalize event is called when a display object is removed
		-- This is used to remove events or cancel timers that were associated with the object
		Runtime:removeEventListener("gameOver", self)
		Runtime:removeEventListener("enterFrame", bgScroll)
		Runtime:removeEventListener("playerEvent", self.enemyPlane)

		if enemySpawnTimer ~= nil then 
   			timer.cancel(enemySpawnTimer)
   			enemySpawnTimer = nil
		end

		bg1 = nil
		bg2 = nil
	end
	self.group:addEventListener("finalize")
end
--======================================================================--
--== Return factory
--======================================================================--
return Game
