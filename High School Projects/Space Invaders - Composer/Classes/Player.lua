-- =============================================================
-- Written by Craig Briggs.  Feel free to modify and reuse in anyway.
--
-- Player.lua
-- Player class,  creates the player
--======================================================================--
--== Player Class factory
--======================================================================--
local Player = class() -- define Player as a class (notice the capitals)
Player.__name = "Player" -- give the class a name

--======================================================================--
--== Require dependant classes
--======================================================================--
local pt = require("Classes.printTable")-- helper class to use when developint
-- pt.print_r(....) will print the contents of a table

local bulletClass 		= require ("Classes.Bullet") -- class for the bullet
-- create this inside the player because it 

local timerOK = true -- used for firing bullets, if this is true then it is OK to fire the bullet


--======================================================================--
--== Initialization / Constructor
--======================================================================--
function Player:__init(group, xloc, yloc, bulletSpeed, bulletInterval )
	-- Constructor for class
		-- Parameters:
		--	group - the group where the game should be inserted into
		--	xloc, yloc - location where it will be drawn
		--  bulletSpeed - speed at which bullets will fire
		--  bulletInterval - gap between bullets
		
	self.group = group
	self.xloc =  xloc
	self.yloc =  yloc
	self.bulletSpeed = bulletSpeed
	self.bulletInterval = bulletInterval
	-- call the method to draw the Player
	self:drawPlayer()
end

--======================================================================--
--== Code / Methods
--======================================================================--

function Player:drawPlayer()
	-- Displays the Player on the screen
	-- Recieves: nil
	-- Returns: nil

	
	-- draw the player
	self.player = display.newImageRect(self.group, "images/player.png", 30, 30 )
	self.player.id = "player"
	self.player.x =  self.xloc
	self.player.y =  self.yloc
	physics.addBody( self.player, "dynamic" )
	
	
	-- add a collision
	-- if it collides with anything except the bullet then dispatch a gameOver
	self.player.collision = function(target, event)
		if event.other.id ~= "bullet" then
			
			local options = {
				name = "gameOver"
			}
			Runtime:dispatchEvent(options)
			display.remove(self.player)

		end
	end
	
	self.player:addEventListener("collision")
	
end

function  Player:getLocation()
	-- access method to return the x and y location
	-- for safety check if player exists
	if not self.player or self.player.removeSelf == nil then return end
	return self.player.x, self.player.y
end

function  Player:move(speed)
	-- move the player
	-- parameters: spped to move at
	
	-- for safety check if player exists
	if not self.player or self.player.removeSelf == nil then return end
	self.player:setLinearVelocity(speed,0)
end

function Player:fireBullet()
	-- fire the bullet
	
	-- for safety check if player exists
	if not self.player or self.player.removeSelf == nil then return end
	
	-- if timerOK then;
		-- fire the bullet
		-- set timerOK to false
		-- create a timer to set timer delay to true after interval
	if timerOK then
		local xLoc, yLoc = self:getLocation()
		timerOK = false
		bulletClass:new(self.group, self.bulletSpeed, xLoc, yLoc)
		self.timer = timer.performWithDelay(self.bulletInterval, function()
			timerOK = true
		end)
	end
end

function Player:desconstuctor()
	-- a finalize event is called when a display object is removed.
	-- we can use this to remove events or cancel timers that were associated with the object
	-- in this case when the player is removed we will remove collision eventListener (not technically needed).
	-- we should then nil out the display object and instance (for good memory management)
	self.player.finalize = function()
		self.player:removeEventListener("collision")
		self.player = nil
		self = nil
	end
	self.player:addEventListener("finalize")
end
--======================================================================--
--== Return factory
--======================================================================--
return Player