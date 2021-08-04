-- =============================================================
-- Written by Matthew Young
--
-- EnemyController.lua
-- EnemyController class,  creates and controls all the enemy instances
--======================================================================--
--== Enemy Class factory
--======================================================================--
local EnemyController = class() -- define Enemy as a class (notice the capitals)
EnemyController.__name = "EnemyController" -- give the class a name

local physics = require ("physics");
local EnemyClass	= require ("Classes.Enemy")
local BulletClass   = require("Classes.Bullet")

-- Constants
local fullw = display.contentWidth
local fullh = display.contentHeight
local centerX = display.contentCenterX
local centerY = display.contentCenterY

local enemies = {}
--======================================================================--
--== Require dependant classes
--======================================================================--

--======================================================================--
--== Initialization / Constructor
--======================================================================--
function EnemyController:__init(group)
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
end

--======================================================================--
--== Code / Methods
--======================================================================--
function EnemyController:spawnEnemies()
	local function spawnEnemies()
		table.insert(enemies, 1)
		local randXSpawn = math.random(30, 295)
		local randYSpawn = math.random(35, 50)
		local randomEnemyNumber = math.random(3)
		if (randomEnemyNumber == 1) then
			enemies[#enemies] = EnemyClass:new(self.group, "images/enemy1.png", randXSpawn, randYSpawn, "regular")
		elseif (randomEnemyNumber == 2) then
			enemies[#enemies] = EnemyClass:new(self.group, "images/enemy2.png", randXSpawn, randYSpawn, "waver")
		else
			enemies[#enemies] = EnemyClass:new(self.group, "images/enemy3.png", randXSpawn, randYSpawn, "chaser")
		end
		print("Spawned Enemies = " .. #enemies)
	end
	enemySpawnTimer = timer.performWithDelay(1000, spawnEnemies, 0)
end
--======================================================================--
--== Return factory
--======================================================================--
return EnemyController