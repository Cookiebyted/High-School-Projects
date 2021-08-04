-- =============================================================
-- Written by Craig Briggs.  Feel free to modify and reuse in anyway.
--
-- Score.lua
-- Score class,  creates an individual instance of the enemies
--======================================================================--
--== Score Class factory
--======================================================================--
local Score = class() -- define Score as a class (notice the capitals)
Score.__name = "Score" -- give the class a name

--======================================================================--
--== Require dependant classes
--======================================================================--
-- Constants
local fullw = display.contentWidth
local fullh = display.contentHeight
local centerX = display.contentCenterX
local centerY = display.contentCenterY
--======================================================================--
--== Initialization / Constructor
--======================================================================--
function Score:__init(group, xloc, yloc, size)
	-- Constructor for class
	-- Parameters:
	--		group - the group where the game should be inserted into
	--		xloc, yloc - location to draw Score 
	--		ScoreSpeed - speed Score will drop at
	
	--		xloc, yloc - location to draw Score 
	--		xloc, yloc - location to draw Score 
	-- Returns:
	--		Reference to instance of class
	self.group = group
	self.xloc = xloc
	self.yloc = yloc
	self.size = size
end

--======================================================================--
--== Code / Methods
--======================================================================--

function  Score:drawScore()
	self.score = display.newText(self.group, "0", self.xloc + 135, self.yloc, nil, self.size)
	self.name = display.newText(self.group, textField.text, centerX, self.yloc, nil, self.size)
	self:deconstructor()
end

function  Score:listen()
	self.enemyTalk = function(self,event)
		if event.type == "dead" then
			print("Enemy has been killed, +1 to score")
			self.score.text = self.score.text + 1
		end
	end

	Runtime:addEventListener("enemyTalk", self)
	self:deconstructor()
end



function Score:deconstructor()
	-- a finalize event is called when a display object is removed.
	-- we can use this to remove events or cancel timers that were associated with the object
	-- in this case when the enemy is removed we will remove event listeners and cancel the timer.
	-- we should then nil out the display object and instance (for good memory management)
	self.score.finalize = function()
		Runtime:removeEventListener("enemyTalk", self)
	end

	self.score:addEventListener("finalize")
end
--======================================================================--
--== Return factory
--======================================================================--
return Score