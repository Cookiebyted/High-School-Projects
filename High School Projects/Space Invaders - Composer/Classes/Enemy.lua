-- =============================================================
-- Written by Craig Briggs.  Feel free to modify and reuse in anyway.
--
-- Enemy.lua
-- Enemy class,  creates an individual instance of the enemies
--======================================================================--
--== Enemy Class factory
--======================================================================--
local Enemy = class() -- define Enemy as a class (notice the capitals)
Enemy.__name = "Enemy" -- give the class a name

--======================================================================--
--== Require dependant classes
--======================================================================--
local pt = require("Classes.printTable") -- helper class to use when developint
-- pt.print_r(....) will print the contents of a table

local bombClass = require("Classes.Bomb") -- require the bomb class here, 
									-- as it is the enemy that will create it

--======================================================================--
--== Initialization / Constructor
--======================================================================--
function Enemy:__init(group, xloc, yloc, bombSpeed, bombIntervalMin, bombIntervalMax )
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
	self.xloc =  xloc
	self.yloc =  yloc
	self.bombSpeed = bombSpeed
	self.bombIntervalMin = bombIntervalMin
	self.bombIntervalMax = bombIntervalMax
	
	-- call the method to draw the Enemy
	self:drawEnemy()
	self:startBombTimer()
end

--======================================================================--
--== Code / Methods
--======================================================================--
function Enemy:setDirection(speed)
	-- move the enemy left or right in the direction of speed
	self.enemy:setLinearVelocity( speed, 0 )
end

function Enemy:startBombTimer()
	-- creates an instance of a bomb 
	-- creates a random number between two values and drops bomb after that amount of time
	-- makes it so bombs happen at random times.
	local function createBomb()
		local randTime = math.random(self.bombIntervalMin, self.bombIntervalMax)
		self.timer = timer.performWithDelay(randTime, function()
			local Bomb = bombClass:new(self.group, self.bombSpeed, self.enemy.x, self.enemy.y)
			createBomb()
		end)
	end
	createBomb()
end

function  Enemy:drawEnemy()
	-- Displays the Enemy on the screen
	-- Recieves: nil
	-- Returns: nil

	self.enemy = display.newImageRect(self.group, "images/enemy.png", 30, 30 )
	self.enemy.id = "enemy"
	self.enemy.x =  self.xloc
	self.enemy.y =  self.yloc
	physics.addBody( self.enemy, "dynamic" )
	
	-- add a collision event
	-- if collision with leftWall or rightWall dispatch an event "enemyTalk" with the details
	self.enemy.collision = function(target, event)
		if event.other.id == "leftWall" or event.other.id == "rightWall" then
			if self.lastCollision ~= event.other.id then
				local options = {
					name = "enemyTalk",
					type = "wallCollision",
					wall = event.other.id,
					}
				Runtime:dispatchEvent(options)
			end
		-- if collision with bullet then remove self
		elseif event.other.id == "bullet" then
			display.remove(self.enemy)
		end
		
	end
	
	self.enemy:addEventListener("collision")
	
	-- call desconstuct
	self:desconstuctor()
end

function  Enemy:listen()
	-- set the enemy to listen for important event
	-- if move then move in that direction
	-- if drop then drop by amount set in init
	function self.enemyInstructions (self, event)
		if event.action == "move" then
			self:setDirection(event.speed)
		elseif event.action == "drop" then
			self.dropTimer = timer.performWithDelay(1, function()
				self.enemy.y = self.enemy.y + event.dropAmount
			end)
		end
	
	end
	Runtime:addEventListener("enemyInstructions", self)
end

function Enemy:desconstuctor()
	-- a finalize event is called when a display object is removed.
	-- we can use this to remove events or cancel timers that were associated with the object
	-- in this case when the enemy is removed we will remove event listeners and cancel the timer.
	-- we should then nil out the display object and instance (for good memory management)

	self.enemy.finalize = function()
		timer.cancel(self.timer)
		timer.cancel(self.dropTimer)
		self.enemy:removeEventListener("collision")
		Runtime:removeEventListener("enemyInstructions", self)
		self.enemy = nil
		self = nil
	end
	self.enemy:addEventListener("finalize")
end
--======================================================================--
--== Return factory
--======================================================================--
return Enemy