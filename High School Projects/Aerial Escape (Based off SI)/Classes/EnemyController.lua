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

local EnemyClass	= require ("Classes.Enemy")

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

function EnemyController:deconstructor()
	-- a finalize event is called when a display object is removed.
	-- we can use this to remove events or cancel timers that were associated with the object
	-- in this case when the enemy is removed we will remove event listeners and cancel the timer.
	-- we should then nil out the display object and instance (for good memory management)

		timer.cancel(enemySpawnTimer)
		for i = 1, #enemies do
    		enemies[i]:removeSelf() -- Optional Display Object Removal
    		enemies[i] = nil        -- Nil Out Table Instance
		end
end
--======================================================================--
--== Return factory
--======================================================================--
return EnemyController