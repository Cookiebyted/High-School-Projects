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

--======================================================================--
--== Require dependant classes
--======================================================================--
local pt = require("Classes.printTable") -- helper class to use when developint
-- pt.print_r(....) will print the contents of a table
local Controls	 	= require ("Classes.Controls") -- 
local Boundary		= require ("Classes.Boundary")
local EnemyClass	= require ("Classes.Enemy")
local PlayerClass 	= require ("Classes.Player")


-- Constants
local fullw = display.contentWidth
local fullh = display.contentHeight
local centerX = display.contentCenterX
local centerY = display.contentCenterY

--======================================================================--
--== Initialization / Constructor
--======================================================================--
function Game:__init(group, options)
	-- Constructor for class
	-- Parameters:
	--		group - the group where the game should be inserted into
	--		options - table containing variables uses to set up the enviroment
	-- Returns:
	--		Reference to instance of class
	
	self.group = group -- the group where the game should be inserted into
	
	-- set up environment, sets default values of nothing is passed over
	local enemyDetails = options.enemyDetails or {}

	self.speed = enemyDetails.startSpeed or 10 -- start speed for the enemies
	self.speedModifer = enemyDetails.speedModifer or 10 -- amount it increases the speed by
	self.dropAmount = enemyDetails.dropAmount or 10 -- how much it will drop by each time it reaches wallHitCount	
	self.wallHitCount = enemyDetails.wallHitCount or 2 -- number of times it will collise with the wall before it drops
	self.maxSpeed = enemyDetails.maxSpeed or 100 -- max speed for enemies, stops them going crazy
	self.bombSpeed = enemyDetails.bombSpeed or 120 -- speed at which bombs drop
	self.bombIntervalMin = enemyDetails.bombIntervalMin or 2000 -- minumim time between bomb drops (indivdual enemy)
	self.bombIntervalMax = enemyDetails.bombIntervalMax or 10000 -- maximum time between bomb drops (indivdual enemy)
	
	local playerDetails = options.playerDetails or {}
	self.playerSpeed = playerDetails.playerSpeed or 120 -- speed player moves across the screen
	self.bulletSpeed = playerDetails.bulletSpeed or 120 -- speed bullets fire up the screen
	self.bulletInterval = playerDetails.bulletInterval -- interval between bullets

	self.lastWall = "" -- reference to the last wall that was collided with, used for enemies
						-- to keep track of movement
	self.wallCount = 0 -- number of enemy wall collisions
	
end

--======================================================================--
--== Code / Methods
--======================================================================--
function Game:setUp()
	-- sets up the game enviroment
	
	-- draw the 3 controls
	local leftKey = Controls:new(self.group, 30,fullh, "images/up.png", -90, "left")
	local rightKey = Controls:new(self.group, fullw-30,fullh, "images/up.png", 90, "right")
	local rightKey = Controls:new(self.group, centerX,fullh, "images/space.png", 0, "space")
	
	-- Add some boundaries
	local Boundary = Boundary:new(self.group)
	
	-- Draw all the enemies
	for y = 1,4 do
		for x = 1, 7 do
			local Enemy = EnemyClass:new(self.group, x * 40,y * 40, self.bombSpeed, self.bombIntervalMin, self.bombIntervalMax)
			Enemy:listen()
		end
	end
	
	-- draw the player
	self.Player =  PlayerClass:new(self.group,centerX,fullh - 50, self.bulletSpeed, self.bulletInterval)
end  

function Game:startGame()
	-- dispatch instructions to enemies to start moving
	local options = { 
		name = "enemyInstructions",
		action = "move",
		speed = self.speed
	}
	Runtime:dispatchEvent(options)
	self:desconstuctor() 
end

function Game:listen()
	-- listen to for custom messages

	self.enemyTalk = function(self, event)
		if event.type == "wallCollision" then -- if there is a wall collision
			if event.wall ~= self.lastWall then	-- and it is different from previous wall collision
				self.wallCount = self.wallCount + 1 -- increase the number of collisions by 1
				
				if self.wallCount % self.wallHitCount == 0 then -- if it is due to drop then
					local options = { -- tell the enemies to drop
						name = "enemyInstructions",
						action = "drop",
						dropAmount = self.dropAmount
					}
					Runtime:dispatchEvent(options) 
					self.speed = self.speed * self.speedModifer -- increase there speed
					if self.speed > self.maxSpeed then
						self.speed = self.maxSpeed
					end
				end
				self.lastWall =  event.wall -- store which wall was hit
				self.speed = self.speed * -1 -- change the direction of hit
				
				local options = { -- tell the enemies to move at set speed
					name = "enemyInstructions",
					action = "move",
					speed = self.speed
				}
				Runtime:dispatchEvent(options)
			end
		end
	
	end
	Runtime:addEventListener("enemyTalk", self)
	
	
	function self.keyPressed (self, event) -- if a key is pressed
		if event.phase == "began" then -- if it is beginning then tell the player to move or fire
			if event.key == "left" then
				self.Player:move(-self.playerSpeed)
			elseif event.key == "right" then
				self.Player:move(self.playerSpeed)
			elseif event.key == "space" then -- 
				self.Player:fireBullet()
				
				
			end
		elseif event.phase == "ended" then -- if press is ended then set move speed to 0
			self.Player:move(0)
		end
	
	end
	Runtime:addEventListener("keyPressed", self)
end

function Game:desconstuctor() 
	self.group.finalize = function()
		-- a finalize event is called when a display object is removed.
		-- we can use this to remove events or cancel timers that were associated with the object
		-- in this case when the main group is removed we will remove two Runtime event listeners
		-- this is VERY important, because having these running in the background will VERY LIKELY
		-- cause an error down the line
		Runtime:removeEventListener("enemyTalk", self)
		Runtime:removeEventListener("keyPressed", self)
	end
	self.group:addEventListener("finalize")
end
--======================================================================--
--== Return factory
--======================================================================--
return Game
