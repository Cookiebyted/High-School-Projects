-- =============================================================
-- Written by Matthew Young.
--
-- Bullet.lua
-- Bullet class - creates the bullet that the player/enemy fires
--======================================================================--
--== Bullet Class factory
--======================================================================--
local Bullet = class() -- define Bullet as a class (notice the capitals)
Bullet.__name = "Bullet" -- give the class a name

--======================================================================--
--== Initialization / Constructor
--======================================================================--
function Bullet:__init(group, xLoc, yLoc, direction, id)
	-- Constructor for class
		-- Parameters:
		--	group 		- the group where the game should be inserted into
		--	xLoc, yLoc  - location where it will be drawn
		--  direction 	- whether the enemy or player is firing
		--  id 			- specify if it is enemyBullet or playerBullet
	self.group = group
	self.xloc =  xLoc
	self.yloc =  yLoc
	self.direction = direction
	self.id = id
	self.speed = 200 -- state speed how fast the bullet will shoot
	
	-- call the method to draw the Bullet
	self:drawBullet()
end

--======================================================================--
--== Code / Methods
--======================================================================--
function Bullet:drawBullet()
	-- Displays the Bullet on the screen
	-- Recieves: nil
	-- Returns: nil
	
	-- Draw the bullet
	self.bullet = display.newRect(self.group, self.xloc, self.yloc, 2, 10)
		print("xLocation = "..self.xloc, " yLocation = ".. self.yloc .. " ID = "..self.id) -- print for testing purposes
    self.bullet.id = self.id -- state bullet id
    self.bullet:setFillColor(1, 0.2, 0.2) -- make the bullet colour red
	
	-- move it up the screen, set it as a sensor so it doesnt cause issues with the player
	physics.addBody(self.bullet, "dynamic", {isSensor = true})

	-- if player is shooting then shoot bullet upwards
	if self.direction == "up" then
		self.bullet:setLinearVelocity(0, -self.speed)
	-- if enemyPlane is shooting then shoot bullet downwards
	elseif self.direction == "down" then
		self.bullet:setLinearVelocity(0, self.speed)
	end

	-- Add collision listener
	self.bullet.collision = function(target, event)
		if self.id == "bullet" and event.other.id == "enemyPlane" then -- If player bullet and enemyPlane collides then call destroy method
			self:destroy()
		elseif self.id == "enemyBullet" and event.other.id == "player" then -- If enemy bullet and player collides then call destroy method
			self:destroy()
		elseif self.id == "bullet" and self.id == "enemyBullet" then -- If the two bullets collide then destroy both bullets
			self:destroy()
		end
	end
	self.bullet:addEventListener("collision")
	self:deconstructor() -- Add deconstuctor method
end

function Bullet:destroy()
	-- Remove bullet
	display.remove(self.bullet)
end

function Bullet:deconstructor()
	-- A finalize event is called when a display object is removed.
	-- We can use this to remove events or cancel timers that were associated with the object
	-- In this case when the bullet is removed we will remove collision event listeners (not technically needed).
	-- We should then nil out the display object and instance (for good memory management)
	self.bullet.finalize = function()
		self.bullet = nil
		self = nil
	end
	self.bullet:addEventListener("finalize")
end
--======================================================================--
--== Return factory
--======================================================================--
return Bullet