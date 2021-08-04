-- =============================================================
-- Written by Matthew Young.
--
-- Enemy.lua
-- Enemy class,  creates an individual instance of the enemies
--======================================================================--
--== Enemy Class factory
--======================================================================--
local Enemy = class() -- define Enemy as a class (notice the capitals)
Enemy.__name = "Enemy" -- give the class a name

-- Constants
local fullw 		= display.contentWidth
local fullh 		= display.contentHeight
local centerX 		= display.contentCenterX
local centerY 		= display.contentCenterY
--======================================================================--
--== Require dependant classes
--======================================================================--
local bulletClass 	= require ("Classes.Bullet") -- Require Bullet Class
local Player 		= require("Classes.Player") -- Require Player Class
--======================================================================--
--== Initialization / Constructor
--======================================================================--
function Enemy:__init(group, image, xloc, yloc, id)
	-- Constructor for class
	-- Parameters:
	--		group 		- the group where the enemies should be inserted into
	--		image 		- the image name file in folder
	--		xloc, yloc  - location to draw enemy 
	--		id 			- id of one of three enemy planes

	-- Returns:
	--		Reference to instance of class

	self.group = group
	self.image = image
	self.xloc =  xloc
	self.yloc =  yloc
	self.id = id
	self.enemyBulletIntervalMin = 500
	self.enemyBulletIntervalMax = 6000
	self:drawEnemy()		-- Call method to draw enemies
	self:startBulletTimer() 	-- Call method to start enemies bullet timers
end
--======================================================================--
--== Code / Methods
--======================================================================--
function Enemy:drawEnemy()
	-- Displays the Enemy on the screen
	-- Recieves: nil
	-- Returns: enemyPlane instance
	self.enemyPlane = display.newImageRect(self.group, self.image, 30 , 30)
	self.enemyPlane.id = self.id
	self.enemyPlane.name = "enemyPlane"

	-- Assign enemyPlane x,y values, add physics body/disable rotation to enemyPlane
	self.enemyPlane.x = self.xloc
	self.enemyPlane.y = self.yloc
	physics.addBody(self.enemyPlane, "dynamic")
	self.enemyPlane.isFixedRotation = true
	
	self.enemyPlane.collision = function(target, event)
		-- Function to handle enemy collision events
		if event.other.id == "bullet" then
			timer.performWithDelay (1, self:destroy()) -- if enemy collides with player bullet, then call destroy method with 1ms delay
		elseif event.other.id == "player" then
			timer.performWithDelay (1, self:destroy()) -- if enemy collides with player, then call destroy method with 1ms delay
		end
	end
	self.enemyPlane:addEventListener("collision") -- Add a collision event listener to enemy
	self:move() -- Call move method
	self:deconstructor() -- Call deconstructor method

	return self.enemyPlane
end

function Enemy:startBulletTimer()
	-- Starts timer for enemy plane firing bullets
	-- Recieves: nil
	-- Returns: nil
	if not self.enemyPlane or self.enemyPlane == nil then return end -- for safety check if enemyPlane exists

	-- creates an instance of a bomb 
	-- creates a random number between two values and drops bomb after that amount of time
	-- makes it so bombs happen at random times.
	local function createBullet()
		local randomTime = math.random(self.enemyBulletIntervalMin, self.enemyBulletIntervalMax)
		self.timer = timer.performWithDelay(randomTime, function()
			local enemyBullet = bulletClass:new(self.group, self.enemyPlane.x, self.enemyPlane.y, "down", "enemyBullet")
			createBullet()
		end)
	end
	createBullet()
end

function Enemy:destroy()
	-- Destroys the enemy
	-- Recieves: nil
	-- Returns: nil

	local options = {name = "enemyTalk", type = "dead"}
	Runtime:dispatchEvent(options)  
	display.remove(self.enemyPlane)
end

function Enemy:move()
	-- Detects what type of enemy plane it is and moves it accordingly
	-- Recieves: nil
	-- Returns: nil

	self.enemyPlane.playerEvent = function(target, event)
		-- if self.id == "regular" then
		-- 	self.enemyPlane.y = (self.enemyPlane.y or 0) + 3
		-- 	print("REGULAR PLANE " .. self.enemyPlane.x .. self.enemyPlane.y)
		-- elseif self.id == "waver" then
		-- 	self.enemyPlane.y = (self.enemyPlane.y or 0) + 2
		-- 	self.enemyPlane.x = (self.enemyPlane.x or 0) + 0.1
		-- 	print("WAVER PLANE " .. self.enemyPlane.x .. self.enemyPlane.y)
		-- elseif self.id == "chaser" then
			if self.transition then
				transition.cancel(self.transition)
			end
			self.transition = transition.to(self.enemyPlane, {time = 1500, x = event.x, y = event.y})
		-- end

		-- if(self.enemyPlane.y > 500) then
		-- 	timer.performWithDelay(1, self.destroy())
		-- end
	end
	Runtime:addEventListener("playerEvent", self.enemyPlane)
end

function Enemy:deconstructor()
	-- a finalize event is called when a display object is removed.
	-- we can use this to remove events or cancel timers that were associated with the object
	-- in this case when the bullet is removed we will remove collision event listeners (not technically needed).
	-- we should then nil out the display object and instance (for good memory management)
	self.enemyPlane.finalize = function()
		timer.cancel(self.timer)
		self.timer = nil
		self.enemyPlane:removeEventListener("collision")
		self.enemyPlane = nil
		self = nil
	end
	self.enemyPlane:addEventListener("finalize")
end
--======================================================================--
--== Return factory
--======================================================================--
return Enemy