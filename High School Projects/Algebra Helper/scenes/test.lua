-- =============================================================
-- 12DTS Composer Example
-- =============================================================
-- Test
-- =============================================================
local composer 		= require( "composer" )
local scene    		= composer.newScene()
local widget 		= require( "widget" )
----------------------------------------------------------------------
--								LOCALS								--
----------------------------------------------------------------------
-- Constants
local fullw = display.contentWidth
local fullh = display.contentHeight
local centerX = display.contentCenterX
local centerY = display.contentCenterY
local testTopics = {"Inequalities", "Simultaneous Equations", "Like Terms", "Polynomials", "One-Step Equations", "Two-Step Equations", "Expanding", "Factorising", "Quadratic Equations", "Discriminants" }
----------------------------------------------------------------------
--	Scene Methods
----------------------------------------------------------------------

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:create( event )

	local sceneGroup = self.view
	-- Place all your code in this section.
	-- Make sure all display objects eventually end up in the screenGroup.
	----------------------------------------------------------------------
	----------------------------------------------------------------------
	local title = display.newText("Test", centerX, centerY - 200, nil, 26)
	sceneGroup:insert(title)
		
	local secondBar = display.newRect(centerX, centerY - 220, fullw + 5, 30)
		secondBar:setFillColor(141/255, 183/255, 250/255)
		secondBar.strokeWidth = 3
		secondBar:setStrokeColor(0, 0, 0 )
		sceneGroup:insert(secondBar)
	
	
	local topBar = display.newRect(centerX, centerY - 260, fullw + 5, 50)
		topBar:setFillColor(74/255,134/255,232/255)
		topBar.strokeWidth = 3
		topBar:setStrokeColor(0, 0, 0 )
		sceneGroup:insert(topBar)
		
	
	 -- Function to handle button events
	local function handleButtonEvent( event )
		if ( "ended" == event.phase ) then
			print( "Button was pressed and released" )
			local options = {
				effect = "slideRight",
				time = 750
			}
			composer.gotoScene("scenes.mainscreen", options)	
		end
	end

	-- -- Create the widget
	local backHomeScreen = widget.newButton(
		{
			label = "Back",
			labelColor = {default={0,0,0,1}, over={0,0,0,1}},
			onEvent = handleButtonEvent,
			-- Properties for a rounded rectangle button
			shape = "roundedRect",
			width = 72,
			height = 20,
			cornerRadius = 2,
			fillColor = {default={207/255,226/255,243/255}, over={187/255, 226/255,243/255}},
			strokeColor = { default={0,0,0,1}, over={0,0,0,1} },
			strokeWidth = 1
		}
	)
	sceneGroup:insert(backHomeScreen)
	-- Center the button
	backHomeScreen.x = secondBar.x - 115
	backHomeScreen.y = secondBar.y + 1
	
	
	local title = display.newText("Test", centerX, secondBar.y + 50, "Merriweather.ttf", 26)
	title:setFillColor(0,0,0)
	sceneGroup:insert(title)
	
	local underScoreOptions = 
	{
		text = "______",     
		x = centerX,
		y = title.y - 30,
		font = "Merriweather.ttf",   
		fontSize = 24,
		align = "centre"  -- Alignment parameter
	}
	
	local underScore = display.newText(underScoreOptions)
		underScore:setFillColor(0,0,0)
		sceneGroup:insert(underScore)
	
	
	local underScore2Options = 
	{
		text = "______",     
		x = centerX,
		y = title.y + 8,
		font = "Merriweather.ttf",   
		fontSize = 24,
		align = "centre"  -- Alignment parameter
	}
	
	local underScore2 = display.newText(underScore2Options)
		underScore2:setFillColor(0,0,0)
		sceneGroup:insert(underScore2)



	local function onRowRender(event)

			local row = event.row	-- Get reference to the row group
			-- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
			local rowHeight = row.contentHeight
			local rowWidth = row.contentWidth
			
			-- Display row names
			local rowTitle = display.newText(row, testTopics[row.index], 0, 0, "Merriweather.ttf", 14 )
				rowTitle:setFillColor(0)
				-- Align the label left and vertically centered
				rowTitle.anchorX = 0
				rowTitle.x = 8
				rowTitle.y = rowHeight * 0.5
			
			local function onObjectTap(event)
				local options = {
					effect = "slideLeft",
					time = 750
				}
				composer.gotoScene("scenes.testScenes.test" .. event.id, options)
				return true
			end
				row.tap = onObjectTap
				row:addEventListener("tap", row)
			end

		-- Create tableView widget
		local tableView = widget.newTableView(
			{
				left = 0,
				top = 100,
				height = 430,
				width = 300,
				onRowRender = onRowRender,
				onRowTouch = onRowTouch,
				listener = scrollListener
			}
		)
		 
		-- Insert 10 rows
		for i = 1, 10 do
			tableView:insertRow{}	-- Insert a row into the tableView
		end
			sceneGroup:insert(tableView) -- Insert the tableView into the sceneGroup 
			
end

---------------------------------------------------------------------------------
-- Generally Do Not Touch Below This Line
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
