-- =============================================================
-- Statistics.lua
-- =============================================================
----------------------------------------------------------------------
--								LOCALS								--
----------------------------------------------------------------------
local composer 		= require( "composer" )
local scene    		= composer.newScene()
local widget 		= require( "widget" )
local loadsaveM 	= require("loadsave")

-- Constants
local fullw, fullh = display.contentWidth, display.contentHeight
local centerX, centerY = display.contentCenterX, display.contentCenterY

local record = {}
----------------------------------------------------------------------
--	Scene Methods
----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:create(event)
	local sceneGroup = self.view

	local topBar = display.newRect(sceneGroup, centerX, centerY - 260, fullw + 5, 50)
	topBar:setFillColor(224/255,102/255,102/255)
	topBar.strokeWidth = 3
	topBar:setStrokeColor(0, 0, 0)

	local title = display.newText(sceneGroup, "Statistics", centerX , topBar.y, native.systemFontBold, 24)
	title:setFillColor(0,0,0)

	local function handleButtonEvent( event )
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
------------------------------------------------------------------------------------------------------
	local function textListener(event)
	    if (event.phase == "began") then
	        -- User begins editing "defaultField"
	    elseif (event.phase == "ended" or event.phase == "submitted") then
	        -- Output resulting text from "defaultField"
	        print( event.target.text )
	    elseif ( event.phase == "editing" ) then
	        print( event.newCharacters )
	        print( event.oldText )
	        print( event.startPosition )
	        print( event.text )
	    end
	end
	 
	-- Create text field
	local firstNameField = native.newTextField(centerX, centerY - 175, 150, 20)
	firstNameField:addEventListener( "userInput", textListener)
	sceneGroup:insert(firstNameField)

	local lastNameField = native.newTextField(centerX, centerY - 110, 150, 20)
	lastNameField:addEventListener("userInput", textListener)
	sceneGroup:insert(lastNameField)

	local textFieldTitle = display.newText(sceneGroup, "Enter Players First Name", centerX , firstNameField.y - 25, native.systemFont, 14)
	textFieldTitle:setFillColor(0,0,0)

	local textFieldTitle2 = display.newText(sceneGroup, "Enter Players Last Name", centerX , lastNameField.y - 25, native.systemFont, 14)
	textFieldTitle2:setFillColor(0,0,0)
-----------------------------------------------------------------------------------------------------   
		-- Create the widget
	-- https://docs.coronalabs.com/api/library/widget/newTableView.html
	-- https://coronalabs.com/blog/2014/03/04/tutorial-advanced-tableview-tactics/
	local tableView = widget.newTableView(
		{
			left = 0,
			isBounceEnabled = true,
			top = 200,
			height = 320,
			width = fullw,
			onRowRender = onRowRender,
			onRowTouch = onRowTouch
		})
	sceneGroup:insert(tableView)

	for i = 1, 20 do
    tableView:insertRow({
        rowHeight = 35,
        rowColor = {default={239/255, 239/255, 239/255}, over={224/255,102/255,102/255}},
    })
	end
	
	local function submitForm(event)
		record.firstName = firstNameField.text	
		record.lastName = lastNameField.text
		for k,v in pairs(record) do
			print(k,v)
		end
		tableView:reloadData()
	end

    local submitButton = widget.newButton({
        width = 160,
        height = 40,
        label = "Submit",
        labelColor = { 
            default = {0.90, 0.60, 0.34}, 
            over = {0.79, 0.48, 0.30} 
        },
        labelYOffset = -4, 
        fontSize = 16,
        emboss = false,
        onRelease = submitForm
    })
    submitButton.x = centerX
    submitButton.y = lastNameField.y + 35
    sceneGroup:insert(submitButton)
	
	local function onRowTouch(event)
        local row = event.row
        local id = row.id
		local params =  event.target.params
		
        if event.phase == "press" or event.phase == "tap" then     
			print("Row " .. id .." pressed")
        end
    end
	
	local function onRowRender( event )
		-- Get reference to the row group
		local row = event.row
		local id = row.index
		local params = event.row.params
		-- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
		local rowHeight = row.contentHeight
		local rowWidth = row.contentWidth

		-- insert a title at the top of each row
		local rowTitle = display.newText(record, 0, 0, nil, 14 )
		rowTitle:setFillColor( 0 )
		row:insert(rowTitle)
		-- Align the label left and vertically at the top
		rowTitle.anchorY = 0
		rowTitle.anchorX = 0
		rowTitle.x = 0
		rowTitle.y = 0
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
