-- =============================================================
-- Home.lua
-- =============================================================
----------------------------------------------------------------------
--								LOCALS								--
----------------------------------------------------------------------
local composer 		= require("composer")
local scene    		= composer.newScene()
local widget 		= require("widget")

-- Constants
local fullw, fullh = display.contentWidth, display.contentHeight
local centerX, centerY = display.contentCenterX, display.contentCenterY

local menuButtons = {"Drills", "Statistics", "Tactics", "Settings"}
local homeButtons = {"images/drills.png", "images/statistics.png", "images/tactics.png", "images/settings.png"}
local topicsTable = {"Topic 1", "Topic 2", "Topic 3"}

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

	local title = display.newText(sceneGroup, "Football Coach", centerX , topBar.y, native.systemFontBold, 24)
	title:setFillColor(0,0,0)

	-- local function handleButtonEvent( event )
	-- 	if ( "ended" == event.phase ) then
	-- 		local id = event.target.id
	-- 		local options = {
	-- 			effect = "fade",
	-- 			time = 200,
	-- 			params = {
	-- 					menuButtons = menuButtons[id],
	-- 			}}
	-- 	composer.gotoScene("scenes.screens.".. menuButtons[id], options)
	-- 	end
	-- end

	-- for count = 1, #menuButtons do
	-- 	local menuButton = widget.newButton(
	-- 		{
	-- 			label = menuButtons[count],
	-- 			onEvent = handleButtonEvent,
	-- 			id = count,
	-- 			x = centerX,
	-- 			y = 100 + count * 40,
	-- 			--defaultFile = homeButtons[count],
	-- 		})
	-- 	sceneGroup:insert(menuButton)
	-- end

	local function menuButton(scene, image, x, y)
		local function handleButtonEvent(event)
			if ( "ended" == event.phase ) then
				local id = event.target.id
				local options = {
					effect = "slideLeft",
					time = 700,
					params = {
							menuButtons = menuButtons[id],
					}}
				composer.gotoScene(scene, options)
			end
		end

		-- Create the widget
		local button = widget.newButton(
			{
				onEvent = handleButtonEvent,
				width = 80,
				height = 80,
				defaultFile = image,
			})
		sceneGroup:insert(button)
		-- Center the button
		button.x = x
		button.y = y
	end

	menuButton("scenes.screens.drills", homeButtons[1], topBar.x - 70, topBar.y + 160) -- Button for Drills
	menuButton("scenes.screens.statistics", homeButtons[2], topBar.x + 70, topBar.y + 160) -- Button for Statistics
	menuButton("scenes.screens.tactics", homeButtons[3], topBar.x - 70, topBar.y + 300) -- Button for Tactics
	menuButton("scenes.screens.settings", homeButtons[4], topBar.x + 70, topBar.y + 300) -- Button for Settings

	local function buttonText(text, x, y)
		local buttonText = display.newText(sceneGroup, text, x, y, native.systemFont, 18)
		buttonText:setFillColor(0,0,0)
	end

	buttonText(menuButtons[1], topBar.x - 70, topBar.y + 220)
	buttonText(menuButtons[2], topBar.x + 70, topBar.y + 220)
	buttonText(menuButtons[3], topBar.x - 70, topBar.y + 370)
	buttonText(menuButtons[4], topBar.x + 70, topBar.y + 370)

	local sidebar = widget.newButton(
		{
			width = 30,
			height = 150,
			defaultFile = "images/sidebar.png",
		})
	sceneGroup:insert(sidebar)
	sidebar.x = centerX - 145
	sidebar.y = centerY - 25

	local sidebarGroup = display.newGroup()
		sidebarGroup.x = 0
		sidebarGroup.y = centerY
		sceneGroup:insert(sidebarGroup)

	local backOpacity = display.newRect(0 , 0, fullw + 10 , fullh + 92)
		backOpacity:setFillColor(230/255, 230/255, 230/255)
		backOpacity:setStrokeColor(0,0,0)
		backOpacity.strokeWidth = 5
		backOpacity.isVisible = false

	local sidebarContainer = display.newRect(0 , 0, 0 - fullw /1, fullh + 90)
		sidebarContainer:setFillColor(230/255, 230/255, 230/255)
		sidebarContainer.isVisible = false

	local sidebar2 = widget.newButton(
		{
			width = 40,
			height = 150,
			defaultFile = "images/sidebar.png",
		})
	sidebarGroup:insert(sidebar2)
	sidebar2.x = sidebarContainer.x + 185
	sidebar2.y = centerY - 250
	sidebar2.isVisible = false

	local text = display.newText(sidebarGroup, "Football Coach", sidebar.x + 65, sidebar.y - 475, native.systemFontBold, 18)
	text:setFillColor(0,0,0)
	text.isVisible = false

	local function onRowRender(event)
		local row = event.row	-- Get reference to the row group
		-- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
		local rowHeight = row.contentHeight
		local rowWidth = row.contentWidth
		
		-- Display row names
		local rowTitle = display.newText(row, menuButtons[row.index], 0, 0, native.systemFont, 14)
			rowTitle:setFillColor(0)
			rowTitle.anchorX = 0
			rowTitle.x = 8
			rowTitle.y = rowHeight * 0.5
		
		local function onObjectTap(event)
			local id = event.target.id
				if id == 1 then
					composer.gotoScene("scenes.screens.drills")
				elseif id == 2 then
					composer.gotoScene("scenes.screens.statistics")
				elseif id == 3 then
					composer.gotoScene("scenes.screens.tactics")
				else
					composer.gotoScene("scenes.screens.settings")
				end
		end
			row:addEventListener("tap", onObjectTap)
		end

	-- Create tableView widget
	local tableView = widget.newTableView(
		{
			left = -2,
			top = 20,
			height = 160,
			width = 163,
			friction = 200,
			maxVelocity = 0.1,
			isBounceEnabled = false,
			onRowRender = onRowRender,
			listener = scrollListener
		})
	 
	-- Insert rows
	for i = 1, #menuButtons do
		tableView:insertRow( -- Insert a row into the tableView
		{
			rowColor = {default={230/255, 230/255, 230/255}, over={230/255, 230/255, 230/255}},
			lineColor = {0, 0, 0}
		})
	end
		sceneGroup:insert(tableView) -- Insert the tableView into the sceneGroup
		tableView.isVisible = false

	sidebarGroup:insert(1, backOpacity)
	sidebarGroup:insert(2, sidebarContainer)

	local function sidebarShowHide(event)
		if (event.phase == "ended") then
			print("sidebarShowHide")
			backOpacity.isVisible = true
			sidebar2.isVisible = true
			text.isVisible = true
			tableView.isVisible = true
			sidebar.isVisible = false
		end
	end

	local function sidebarHideBodyClick (event)
		if (event.phase == "ended") then
			print("sidebarHideBodyClick")
			backOpacity.isVisible = false
			sidebar2.isVisible = false
			text.isVisible = false
			tableView.isVisible = false
			sidebar.isVisible = true
		end
	end
	
	sidebar:addEventListener("touch", sidebarShowHide)
	backOpacity:addEventListener("touch", sidebarHideBodyClick)
	sidebar2:addEventListener("touch", sidebarHideBodyClick)
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
