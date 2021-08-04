-- =============================================================
-- Written by Matthew Young.
-- main.lua
-- main file where the environment is set up, and points in the direction of first scene
-- =============================================================

----------------------------------------------------------------------
--	1. Requires
----------------------------------------------------------------------
-- http://docs.coronalabs.com/daily/api/library/composer/index.html
local composer 	= require "composer" 

math.randomseed(os.time())

-- library that adds OOP functionality
require("Classes.30logglobal")

-- helper class to use when developint, adds ability to print tables
-- can use table.print ( table ) to print a tables contents
require("Classes.printTable") 


-- set up physics environment
local physics = require( "physics" )
physics.start()
--physics.setDrawMode("hybrid")  -- can be used for debugging purposes
physics.setGravity(0, 0) -- set the gravity to 0, we want to use physics, but gravity is not needed
----------------------------------------------------------------------
--	2. Initialization
----------------------------------------------------------------------
composer.gotoScene( "scenes.mainMenu" )	-- goto the menu
