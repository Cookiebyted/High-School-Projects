-- =============================================================
-- Written by Craig Briggs.  Feel free to modify and reuse in anyway.
--
-- Bomb.lua
-- Bomb class,  creates the bombs that the bomb drop
--======================================================================--
--== Bomb Class factory
--======================================================================--
local Bomb = class() -- define Bomb as a class (notice the capitals)
Bomb.__name = "Bomb" -- give the class a name

--======================================================================--
--== Require dependant classes
--======================================================================--
local pt = require("Classes.printTable") -- helper class to use when developint
-- pt.print_r(....) will print the contents of a table

--======================================================================--
--== Initialization / Constructor
--======================================================================--
function Bomb:__init(group, speed, xLoc, yLoc )
	-- Constructor for class
		-- Parameters:
		--	group - the group where the game should be inserted into
		--	xLoc, yLoc - location where it will be drawn
		--  speed - speed at which it wil be drawn
	self.group = group
	self.xLoc =  xLoc
	self.yLoc =  yLoc
	self.speed = speed
	-- call the method to draw the Bomb
	self:drawBomb()
end

--======================================================================--
--== Code / Methods
--======================================================================--

function Bomb:drawBomb()
	-- Displays the Bomb on the screen
	-- Recieves: nil
	-- Returns: nil
	
	-- draw the bomb
	self.bomb = display.newRect(self.group,self.xLoc, self.yLoc,  2,10)--display.newImageRect(self.group, "images/player.png", 30, 30 )
    self.bomb:setFillColor(1,0,0)
	self.bomb.id = "bomb"
	
	-- move it down the screen, set it as a sensor so it doesnt cause
	-- issues with the enemies
	physics.addBody( self.bomb, "dynamic", {isSensor = true} )
	self.bomb:setLinearVelocity(0,self.speed)
	
	-- add collisions and deconstructor
	self:addCollision()
	self:desconstuctor()
end

function Bomb:addCollision()
	-- if it collides with anything except the enemy then remove the bomb
	self.bomb.collision = function(target, event)
		if event.other.id ~= "enemy" then
			display.remove(self.bomb)
		end
	end
	
	self.bomb:addEventListener("collision")
end

function Bomb:desconstuctor()
	-- a finalize event is called when a display object is removed.
	-- we can use this to remove events or cancel timers that were associated with the object
	-- in this case when the bomb is removed we will remove collision event listeners (not technically needed).
	-- we should then nil out the display object and instance (for good memory management)
	self.bomb.finalize = function()
		self.bomb:removeEventListener("collision")
		self.bomb = nil
		bomb = nil
	end
	self.bomb:addEventListener("finalize")
end
--======================================================================--
--== Return factory
--======================================================================--
return Bomb