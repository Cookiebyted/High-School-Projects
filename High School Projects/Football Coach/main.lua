-- =============================================================
-- Main.lua
-- =============================================================

----------------------------------------------------------------------
--	1. Requires
----------------------------------------------------------------------
-- http://docs.coronalabs.com/daily/api/library/composer/index.html
local composer 	= require "composer" 

local loadsaveM = require("loadsave")

----------------------------------------------------------------------
--	2. Initialization
----------------------------------------------------------------------
display.setDefault("background", 239/255, 239/255, 239/255) -- Set a default background for the app
composer.isDebug = true -- Turn on debug output for composer + Various other settings

-- Create a table that needs to be stored
local myData = {}
-- myData.currentLevel = 3
-- myData.currentSceneName = "game"
-- myData.highScore = 30000
-- myData.difficulty = "easy"
-- myData.test = {}
-- myData.test[1] = "Test Storage Space 1"
-- myData.test[2] = "Test Array Space 2"

print("\nThis is the original table")
loadsaveM.print_r(myData)

-- save the table to a file called myData.json
loadsaveM.saveTable(myData, "myData.json")

-- nil the table out
myData = nil
print("\nThis is the table after I have nilled it out")
loadsaveM.print_r(myData)

-- load the table from a file called myData.json
myData = loadsaveM.loadTable("myData.json")
print("\nThis is the table after I loaded it back in")
loadsaveM.print_r(myData)

composer.gotoScene("scenes.home") -- Go to home composer screen after main.lua initialization 