-- =============================================================
-- Drills.lua
-- =============================================================
----------------------------------------------------------------------
--								LOCALS								--
----------------------------------------------------------------------
local composer 		= require( "composer" )
local scene    		= composer.newScene()
local widget 		= require( "widget" )

-- Constants
local fullw, fullh = display.contentWidth, display.contentHeight
local centerX, centerY = display.contentCenterX, display.contentCenterY

local topicsTable = {"Topic 1", "Topic 2", "Topic 3", "Topic 4", "Topic 5", "Topic 6", "Topic 7", "Topic 8", "Topic 9", "Topic 10", "Topic 11", "Topic 12", "Topic 13", "Topic 14", "Topic 15", "Topic 16", "Topic 17"}
----------------------------------------------------------------------
--	Scene Methods
----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:create( event )
	local sceneGroup = self.view
		
	local topBar = display.newRect(sceneGroup, centerX, centerY - 260, fullw + 5, 50)
	topBar:setFillColor(224/255,102/255,102/255)
	topBar.strokeWidth = 3
	topBar:setStrokeColor(0, 0, 0)

	local heading = display.newText(sceneGroup, "Drills", centerX , topBar.y, native.systemFontBold, 24)
	heading:setFillColor(0,0,0)

	local title = display.newText(sceneGroup, "Drills", centerX , topBar.y + 80, native.systemFontBold, 24)
	title:setFillColor(0,0,0)

	local function underscore(y)
		local underScoreOptions = 
		{
			text = "_____________",     
			x = centerX,
			y = y,
			fontSize = 24,
			align = "centre"  -- Alignment parameter
		}
		
		local underScore = display.newText(underScoreOptions)
			underScore:setFillColor(0,0,0)
			sceneGroup:insert(underScore)
	end

	underscore(title.y - 35)
	underscore(title.y + 10)

	local function handleButtonEvent(event)
		if ( "ended" == event.phase ) then
			print( "Button was pressed and released" )
			local options = {
				effect = "slideRight",
				time = 750
			}
			composer.gotoScene("scenes.home", options)	
		end
	end
	
	-- -- Create the widget
	local backHomeScreen = widget.newButton(
		{
			onEvent = handleButtonEvent,
			width = 32,
			height = 32,
			defaultFile = "images/arrow.png",
		})
	sceneGroup:insert(backHomeScreen)
	-- Center the button
	backHomeScreen.x = topBar.x - 135
	backHomeScreen.y = topBar.y

	local function onRowTouch(event)
		local row = event.row
        local id = row.id
		local params =  event.target.params
			local options = {
					effect = "slideLeft",
					time = 750,
					params = {
						subjects = topicsTable[id]
			}}
			composer.gotoScene("scenes.standard", options)
	end

	local function onRowRender(event)
		local row = event.row	-- Get reference to the row group
		local id = row.index
		local params = event.row.params
		-- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
		local rowHeight = row.contentHeight
		local rowWidth = row.contentWidth
		
		-- Display row names
		local rowTitle = display.newText(row, topicsTable[row.index], 0, 0, native.systemFont, 14)
			rowTitle:setFillColor(0)
			rowTitle.anchorX = 0
			rowTitle.x = 8
			rowTitle.y = rowHeight * 0.5
	end

	-- Create tableView widget
	local tableView = widget.newTableView({
			left = 0,
			top = 100,
			height = 430,
			width = 310,
			friction = 200,
			maxVelocity = 0.1,
			isBounceEnabled = false,
			onRowRender = onRowRender,
			onRowTouch = onRowTouch,
		})
	sceneGroup:insert(tableView) -- Insert the tableView into the sceneGroup
	 
	-- Insert rows
	for i = 1, #topicsTable do
		tableView:insertRow({ -- Insert a row into the tableView
			rowColor = {default={239/255, 239/255, 239/255}, over={224/255,102/255,102/255}},
			rowHeight = 35,
			lineColor = {0, 0, 0}
		})
	end
end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:willEnter( event )
	local sceneGroup = self.view
end
----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:didEnter( event )
	local sceneGroup = self.view
	local prevScene = composer.getSceneName( "previous" )
	if prevScene then
		composer.removeScene( prevScene, true ) 
		print("removing ", prevScene)
	end
end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:willExit( event )
	local sceneGroup = self.view
end
----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:didExit( event )
	local sceneGroup = self.view
end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:destroy( event )
	local sceneGroup = self.view
end

----------------------------------------------------------------------
--				FUNCTION/CALLBACK DEFINITIONS						--
----------------------------------------------------------------------

---------------------------------------------------------------------------------
-- Scene Dispatch Events, Etc. - Generally Do Not Touch Below This Line
---------------------------------------------------------------------------------
function scene:show( event )
	local sceneGroup 	= self.view
	local willDid 	= event.phase
	if( willDid == "will" ) then
		self:willEnter( event )
	elseif( willDid == "did" ) then
		self:didEnter( event )
	end
end
function scene:hide( event )
	local sceneGroup 	= self.view
	local willDid 	= event.phase
	if( willDid == "will" ) then
		self:willExit( event )
	elseif( willDid == "did" ) then
		self:didExit( event )
	end
end
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
---------------------------------------------------------------------------------
return scene
