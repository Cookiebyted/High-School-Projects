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

-- Constants
local fullw = display.contentWidth
local fullh = display.contentHeight
local centerX = display.contentCenterX
local centerY = display.contentCenterY
--======================================================================--
--== Require dependant classes
--======================================================================--
local bulletClass 		= require ("Classes.Bullet") -- class for the bullet
-- create this inside the player because it 


--======================================================================--
--== Initialization / Constructor
--======================================================================--
function Player:__init(group, xloc, yloc, playerSpeed, bulletInterval, id)
	-- Constructor for class
		-- Parameters:
		--	group - the group where the game should be inserted into
		--	xloc, yloc - location where it will be drawn
		--  bulletInterval - gap between bullets
		
	self.group = group
	self.xloc =  xloc
	self.yloc =  yloc
	self.bulletInterval = bulletInterval
	self.playerSpeed = playerSpeed
	self.id = id
	self.lives = 3
	self.timerOK = true -- used for firing bullets, if this is true then it is OK to fire the bullet
	-- call the method to draw the Player
end

--======================================================================--
--== Code / Methods
--======================================================================--

function Player:draw()
	-- Displays the Player on the screen
	-- Recieves: nil
	-- Returns: nil

	-- draw the player
	self.player = display.newImageRect(self.group, "images/player.png", 40, 50 )
	self.player.id = "player"
	self.player.x =  self.xloc
	self.player.y =  self.yloc
	physics.addBody( self.player, "dynamic" )
	self.player.isFixedRotation = true
	
	self.player.collision = function(target, event)
		if event.other.name == "enemyPlane" then
			self.player:setLinearVelocity(0, 0)
			print("Player lives left = " .. self.lives)
			if self.lives > 0 then
				self.lives = self.lives - 1
			elseif self.lives <= 0 then
				self:destroy()
			end
		elseif event.other.id == "enemyBullet" then
			print("Player lives left = " .. self.lives)
			if self.lives > 0 then
				self.lives = self.lives - 1
			elseif self.lives <= 0 then
				self:destroy()
			end
		end
	end
	self.player:addEventListener("collision")
	self:deconstructor()
end

function  Player:move(xSpeed, ySpeed)
	-- move the player
	-- parameters: spped to move at
	
	-- for safety check if player exists
	if not self.player or self.player.removeSelf == nil then return end
	self.player.x = self.player.x + xSpeed
	self.player.y = self.player.y + ySpeed

	if (self.player.x > 310) then
		self.player.x = 310
	end
	if (self.player.x < 15) then
		self.player.x = 15
	end
	if(self.player.y > 455) then
		self.player.y = 455
	end
	if (self.player.y < 25) then
		self.player.y = 25
	end

	local customEvent = {
		name = "playerEvent",
		x = self.player.x,
		y = self.player.y
	}
	Runtime:dispatchEvent(customEvent)
end

function  Player:destroy(speed)
	display.remove(self.player)
	local options = {
		name = "gameOver"
	}
	Runtime:dispatchEvent(options)
	self.player = nil
	self = nil
end

function Player:shoot()
	-- fire the bullet
	
	-- for safety check if player exists
	if not self.player or self.player.removeSelf == nil then return end
	
	-- if timerOK then;
		-- fire the bullet
		-- set timerOK to false
		-- create a timer to set timer delay to true after interval
	if self.timerOK then
		self.timerOK = false
		local bullet = bulletClass:new(self.group, self.player.x, self.player.y - 15, "up", "bullet")
		self.timer = timer.performWithDelay(self.bulletInterval, function()
			self.timerOK = true
		end)
	end
end

function Player:listen()
	function self.keyPressed (self, event) -- if a key is pressed
		if event.phase == "began" then -- if it is beginning then tell the player to move or fire
			if event.key == "left" then
				self:move(-self.playerSpeed, 0)
			elseif event.key == "right" then
				self:move(self.playerSpeed, 0)
			elseif event.key == "up" then
				self:move(0, -self.playerSpeed)
			elseif event.key == "down" then
				self:move(0, self.playerSpeed)
			elseif event.key == "space" then -- 
				self:shoot()
			end
		elseif event.phase == "ended" then -- if press is ended then set move speed to 0
			self:move(0, 0)
		end
	end
	Runtime:addEventListener("keyPressed", self)
end


function Player:deconstructor()
	-- a finalize event is called when a display object is removed.
	-- we can use this to remove events or cancel timers that were associated with the object
	-- in this case when the player is removed we will remove collision eventListener (not technically needed).
	-- we should then nil out the display object and instance (for good memory management)
	self.player.finalize = function()
		self.player = nil
		self = nil
	end
	self.player:addEventListener("finalize")
end
--======================================================================--
--== Return factory
--======================================================================--
return Player