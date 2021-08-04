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

local fullw = display.contentWidth
local fullh = display.contentHeight
local centerX = display.contentCenterX
local centerY = display.contentCenterY
--======================================================================--
--== Require dependant classes
--======================================================================--
local bulletClass 		= require ("Classes.Bullet") -- class for the bullet
local Player 			= require("Classes.Player")
									-- as it is the enemy that will create it
--======================================================================--
--== Initialization / Constructor
--======================================================================--
function Enemy:__init(group, image, xloc, yloc, id)
	-- Constructor for class
	-- Parameters:
	--		group - the group where the game should be inserted into
	--		xloc, yloc - location to draw enemy 
	--		bombSpeed - speed bomb will drop at
	
	--		xloc, yloc - location to draw enemy 
	--		xloc, yloc - location to draw enemy 
	-- Returns:
	--		Reference to instance of class
	self.group = group
	self.image = image
	self.xloc =  xloc
	self.yloc =  yloc
	self.id = id
	self.enemyBulletIntervalMin = 500
	self.enemyBulletIntervalMax = 6000
	self:drawEnemy()
	self:startBulletTimer()
end

--======================================================================--
--== Code / Methods
--======================================================================--
function Enemy:drawEnemy()
	-- Displays the Enemy on the screen
	-- Recieves: nil
	-- Returns: nil
	self.enemyPlane = display.newImageRect(self.group, self.image, 30 , 30)
	self.enemyPlane.id = self.id
	self.enemyPlane.name = "enemyPlane"

	self.enemyPlane.x = self.xloc
	self.enemyPlane.y = self.yloc
	physics.addBody(self.enemyPlane, "dynamic")
	self.enemyPlane.isFixedRotation = true
	
	self.enemyPlane.collision = function(target, event)
		if event.other.id == "bullet" then
			timer.performWithDelay (1, self:destroy())
		elseif event.other.id == "player" then
			timer.performWithDelay (1, self:destroy())
		end
	end
	self.enemyPlane:toBack()
	self.enemyPlane:addEventListener("collision")
	self:move()
end

function Enemy:startBulletTimer()
	local function createBullet()
		local randomTime = math.random(self.enemyBulletIntervalMin, self.enemyBulletIntervalMax)
		enemyBulletTimer = timer.performWithDelay(randomTime, function()
			local enemyBullet = bulletClass:new(self.group, self.enemyPlane.x, self.enemyPlane.y + 2, "down", "enemyBullet")
			createBullet()
		end)
	end
	createBullet()
end

function Enemy:destroy()
	-- Destroys the enemy
	-- Recieves: nil
	-- Returns: nil
	display.remove(self.enemyPlane)
end

function Enemy:move()
	-- movement = transition.to(self.enemyPlane, {time = 1000, x = self.enemyPlane.y + 100})
	self.enemyPlane.playerEvent = function(target, event)
		if self.id == "regular" then
			self.enemyPlane.y = (self.enemyPlane.y or 0) + 3
		elseif self.id == "waver" then
			self.enemyPlane.y = (self.enemyPlane.y or 0) + 2
			self.enemyPlane.x = (self.enemyPlane.x or 0) + 0.1
		elseif self.id == "chaser" then
			if self.transition then
				transition.cancel(self.transition)
			end
			self.transition = transition.to(self.enemyPlane, {time = 1500, x = event.x, y = event.y})
		end

		if(self.enemyPlane.y > 500) then
			timer.performWithDelay( 1, self.destroy())
		end
	end
	Runtime:addEventListener("playerEvent", self.enemyPlane)
end
--======================================================================--
--== Return factory
--======================================================================--
return Enemy