-- =============================================================
-- Written by Craig Briggs.  Feel free to modify and reuse in anyway.
--
-- Bullet.lua
-- Bullet class,  creates the bullet that the player fires
--======================================================================--
--== Bullet Class factory
--======================================================================--
local Bullet = class() -- define Bullet as a class (notice the capitals)
Bullet.__name = "Bullet" -- give the class a name

--======================================================================--
--== Require dependant classes
--======================================================================--


--======================================================================--
--== Initialization / Constructor
--======================================================================--
function Bullet:__init(group, xLoc, yLoc, direction, id)
	-- Constructor for class
		-- Parameters:
		--	group - the group where the game should be inserted into
		--	xLoc, yLoc - location where it will be drawn
		--  speed - speed at which it will move
	self.group = group
	self.xloc =  xLoc
	self.yloc =  yLoc
	self.direction = direction
	self.id = id
	self.speed = 200
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
	
	-- draw the bullet
	self.bullet = display.newRect(self.group, self.xloc, self.yloc, 2, 10)
		print("xLocation = "..self.xloc,"yLocation = "..self.yloc,"ID = "..self.id)
    self.bullet.id = self.id
    self.bullet:setFillColor(1, 0.2, 0.2)
	
	-- move it up the screen, set it as a sensor so it doesnt cause issues with the player
	physics.addBody(self.bullet, "dynamic", {isSensor = true})

	if self.direction == "up" then
		self.bullet:setLinearVelocity(0, -self.speed)
	elseif self.direction == "down" then
		self.bullet:setLinearVelocity(0, self.speed)
	end

	-- add collisions and deconstructor
	self.bullet.collision = function(target, event)
		if self.id == "bullet" and event.other.id == "enemyPlane" then
			self:destroy()
		elseif self.id == "enemyBullet" and event.other.id == "player" then
			self:destroy()
		-- elseif self.id == "bullet" and self.id == "enemyBullet" then
		-- 	self:destroy()
		end
	end
	self.bullet:toBack()
	self.bullet:addEventListener("collision")
	self:deconstructor()
end

function Bullet:destroy()
	-- if it collides with anything except the player then remove the bomb
	display.remove(self.bullet)
end

function Bullet:deconstructor()
	-- a finalize event is called when a display object is removed.
	-- we can use this to remove events or cancel timers that were associated with the object
	-- in this case when the bullet is removed we will remove collision event listeners (not technically needed).
	-- we should then nil out the display object and instance (for good memory management)
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