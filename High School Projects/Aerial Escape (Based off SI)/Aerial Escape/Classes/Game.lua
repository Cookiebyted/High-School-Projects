-- =============================================================
-- Written by Craig Briggs.  Feel free to modify and reuse in anyway.
--
-- game.lua
-- Main game class,  creates the environment and communicate between classes
-- =============================================================

--======================================================================--
--== Game Class factory
--======================================================================--
local Game = class() -- define Game as a class (notice the capitals)
Game.__name = "Game" -- give the class a name
local composer 		= require("composer") 
--======================================================================--
--== Require dependant classes
--======================================================================--
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
	--		options - table containing variables uses to set up the enviroment
	-- Returns:
	--		Reference to instance of class
	
	self.group = group -- the group where the game should be inserted into
	-- set up environment, sets default values of nothing is passed over
end

--======================================================================--
--== Code / Methods
--======================================================================--
function Game:setUp()
	-- sets up the game enviroment

	self:createScrollingBackground()

	local myRectangle = display.newRect(self.group, centerX, centerY - 260, 325, 50)
	local myRectangle2 = display.newRect(self.group, centerX, centerY + 260, 325, 55)

	myRectangle:setFillColor(0)
	myRectangle:setStrokeColor(1, 1, 1)
	myRectangle:toFront()

	myRectangle2:setFillColor(0)
	myRectangle2:setStrokeColor(1, 1, 1)
	myRectangle2:toFront()

	local leftKey = ControlsClass:new(self.group, 30, fullh + 18, "images/up.png", -90, "left")
	local rightKey = ControlsClass:new(self.group, fullw-30 ,fullh + 18, "images/up.png", 90, "right")
	local spaceKey = ControlsClass:new(self.group, centerX,fullh + 18, "images/space.png", 0, "space")
	local upKey = ControlsClass:new(self.group, 100,fullh + 18, "images/up.png", 0, "up")
	local downKey = ControlsClass:new(self.group, 220, fullh + 18, "images/up.png", 180, "down")

	local enemyController = EnemyControllerClass:new(self.group)
	enemyController:spawnEnemies()

	-- -- draw the player
	local player = PlayerClass:new(self.group, centerX, fullh - 50, 3, 350, "player")
	player:draw()
	player:listen()

	local score = ScoreClass:new(self.group, centerX, -20, 28)
	score:drawScore()
	score:listen()
	  
	self:deconstructor()
end  

function Game:createScrollingBackground()
	-- Display Image and loop it scrolling infinitely
	bg1 = display.newImage("images/background1.png", centerX, centerY)
 	bg1.x = centerX
 	bg1.y = centerY

	bg2 = display.newImage("images/background1.png", centerX, centerY)
 	bg2.x = centerX
 	bg2.y = centerY - fullh

	local scrollSpeed = 4
 
	local function bgScroll (event)
	    bg1.y = bg1.y + scrollSpeed
	    bg2.y = bg2.y + scrollSpeed
	    if bg1.y == fullh * 1.5 then
	        bg1.y = fullh * -0.5
	    end
	    if bg2.y == fullh * 1.5 then
	        bg2.y = fullh * -0.5
	    end
	end
	Runtime:addEventListener("enterFrame", bgScroll)
	bg1:toBack()
	bg2:toBack()
end

function Game:listenGameOver()
	-- listen to for custom messages
	function self.gameOver (self, event) -- if a key is pressed
		local options = {
			effect = "fade",
			time = 800,
		}
		composer.gotoScene("scenes.gameOver", options)
		if (enemySpawnTimer) then 
   			timer.cancel(enemySpawnTimer)
   			enemySpawnTimer = nil
		end

		if (enemyBulletTimer) then
   			timer.cancel(enemyBulletTimer)
   			enemyBulletTimer = nil
		end
	end
	Runtime:addEventListener("gameOver", self)
end

function Game:deconstructor() 
	self.group.finalize = function()
		-- a finalize event is called when a display object is removed.
		-- we can use this to remove events or cancel timers that were associated with the object
		-- in this case when the main group is removed we will remove two Runtime event listeners
		-- this is VERY important, because having these running in the background will VERY LIKELY
		-- cause an error down the line
		Runtime:removeEventListener("gameOver", self)
		Runtime:removeEventListener("enterFrame", bgScroll)
		Runtime:removeEventListener("playerEvent", self.enemyPlane)
	end
	self.group:addEventListener("finalize")
end
--======================================================================--
--== Return factory
--======================================================================--
return Game
