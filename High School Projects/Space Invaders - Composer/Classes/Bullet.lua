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
local pt = require("Classes.printTable") -- helper class to use when developint
-- pt.print_r(....) will print the contents of a table

--======================================================================--
--== Initialization / Constructor
--======================================================================--
function Bullet:__init(group, speed, xloc, yLoc )
	-- Constructor for class
		-- Parameters:
		--	group - the group where the game should be inserted into
		--	xLoc, yLoc - location where it will be drawn
		--  speed - speed at which it will move
	self.group = group
	self.xloc =  xloc
	self.yloc =  yLoc
	self.speed = speed
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
	self.bullet = display.newRect(self.group,self.xloc, self.yloc,  2,10)--display.newImageRect(self.group, "images/player.png", 30, 30 )
    self.bullet.id = "bullet"
	
	-- move it up the screen, set it as a sensor so it doesnt cause
	-- issues with the player
	physics.addBody( self.bullet, "dynamic", {isSensor = true} )
	self.bullet:setLinearVelocity(0,-self.speed)
	
	-- add collisions and deconstructor
	self:addCollision()
	self:desconstuctor()
end

function Bullet:addCollision()
	-- if it collides with anything except the player then remove the bomb
	self.bullet.collision = function(target, event)
		if event.other.id ~= "player" then
			display.remove(self.bullet)
		end
	end
	
	self.bullet:addEventListener("collision")
end

function Bullet:desconstuctor()
	-- a finalize event is called when a display object is removed.
	-- we can use this to remove events or cancel timers that were associated with the object
	-- in this case when the bullet is removed we will remove collision event listeners (not technically needed).
	-- we should then nil out the display object and instance (for good memory management)
	self.bullet.finalize = function()
		self.bullet:removeEventListener("collision")
		self.bullet = nil
		self = nil
	end
	self.bullet:addEventListener("finalize")
end
--======================================================================--
--== Return factory
--======================================================================--
return Bullet