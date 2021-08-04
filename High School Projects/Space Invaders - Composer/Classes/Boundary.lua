-- =============================================================
-- Written by Craig Briggs.  Feel free to modify and reuse in anyway.
--
-- Boundary.lua
-- Boundary class,  creates teh boundaries that surround the screen
--======================================================================--
--== Boundary Class factory
--======================================================================--
local Boundary = class() -- define Boundary as a class (notice the capitals)
Boundary.__name = "Boundary" -- give the class a name


-- Constants
local fullw = display.contentWidth
local fullh = display.contentHeight
local centerX = display.contentCenterX
local centerY = display.contentCenterY

--======================================================================--
--== Require dependant classes
--======================================================================--
local pt = require("Classes.printTable") -- helper class to use when developint
-- pt.print_r(....) will print the contents of a table


--======================================================================--
--== Initialization / Constructor
--======================================================================--
function Boundary:__init(group)
	-- Constructor for class
	-- Parameters:
	--		group - the group where the game should be inserted into
	
	self.group = group
	self:drawBoundary()

end

--======================================================================--
--== Code / Methods
--======================================================================--
function  Boundary:drawBoundary()
	-- Displays the Boundary on the screen
	-- Recieves: nil
	-- Returns: nil
	
	-- create a table containing relevant data about the walls
	local walls = {
		{0,centerY,5,fullh, "leftWall"},
		{fullw,centerY,5,fullh, "rightWall"},
		{centerX,0,fullw,5},
		{centerX,fullh,fullw,5}
	}
	
	-- loop through and create walls
	for i = 1,4 do
		local wall = display.newRect(self.group, walls[i][1],walls[i][2],walls[i][3],walls[i][4])
		wall.id = walls[i][5] or "wall"
		wall.alpha = 0
		physics.addBody( wall, "static" )
	end
	
end

--======================================================================--
--== Return factory
--======================================================================--
return Boundary