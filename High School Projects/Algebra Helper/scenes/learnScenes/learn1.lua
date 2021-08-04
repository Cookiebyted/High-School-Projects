-- =============================================================
-- 12DTS Composer Example
-- =============================================================
-- Learn 1 - Inequalities
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
	
	local underScoreOptions = 
	{
		text = "______",     
		x = centerX,
		y = centerY - 200,
		font = "Merriweather.ttf",   
		fontSize = 24,
		align = "centre"  -- Alignment parameter
	}
	
	local underScore = display.newText(underScoreOptions)
		underScore:setFillColor(0,0,0)
		sceneGroup:insert(underScore)
		
	local title = display.newText( "Inequalities", centerX, underScore.y + 30, "Merriweather.ttf", 24 )
	title:setFillColor(0, 0, 0)
	sceneGroup:insert(title)
	
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
	

	-- Function to handle button events
	local function testHandleButtonEvent(event)
		if ( "ended" == event.phase ) then
			print( "Button was pressed and released" )
			local options = {
				effect = "slideLeft",
				time = 750
			}
			composer.gotoScene("scenes.testScenes.test1", options)	
		end
	end

	-- -- Create the widget
	local testButton = widget.newButton(
		{
			label = "Try the Test",
			labelColor = {default={0,0,0,1}, over={0,0,0,1}},
			onEvent = testHandleButtonEvent,
			-- Properties for a rounded rectangle button
			shape = "roundedRect",
			width = 100,
			height = 20,
			cornerRadius = 2,
			fillColor = {default={207/255,226/255,243/255}, over={187/255, 226/255,243/255}},
			strokeColor = { default={0,0,0,1}, over={0,0,0,1} },
			strokeWidth = 1
		}
	)
	-- Center the button
	testButton.x = secondBar.x + 100
	testButton.y = secondBar.y + 1
	sceneGroup:insert(testButton)
	
	
		-- Function to handle button events
	local function backHandleButtonEvent(event)
		if ( "ended" == event.phase ) then
			print( "Button was pressed and released" )
			local options = {
				effect = "slideRight",
				time = 750
			}
			composer.gotoScene("scenes.learn", options)	
		end
	end

	-- -- Create the widget
	local backButton = widget.newButton(
		{
			label = "Back",
			labelColor = {default={0,0,0,1}, over={0,0,0,1}},
			onEvent = backHandleButtonEvent,
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
	-- Center the button
	backButton.x = secondBar.x - 115
	backButton.y = secondBar.y + 1
	sceneGroup:insert(backButton)
	
	local function scrollListener( event )
		local phase = event.phase
		local direction = event.direction
		
		if event.limitReached then
			if "up" == direction then
				print("Bottom")
			elseif "down" == direction then
				print("Top")
			end
		end
		return true
	end

	local scrollView = widget.newScrollView
	{
		left = 0,
		top = 110,
		width = display.contentWidth,
		topPadding = -150,
		bottomPadding = 100,
		horizontalScrollDisabled = true,
		verticalScrollDisabled = false,
		isBounceEnabled = false,
		listener = scrollListener,
	}
	
	local lotsOfText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sodales, justo et lobortis sodales, nisl ante euismod diam, fringilla pulvinar nisl ante ac nisi. Fusce sem tellus, pharetra facilisis elementum quis, blandit ut augue. Integer vel magna eget eros feugiat aliquam sed convallis magna. Etiam luctus leo lacinia magna elementum elementum. Nunc rhoncus purus eu volutpat posuere. Nunc commodo feugiat velit in dapibus. Integer lacinia interdum congue. In pharetra malesuada ex in porttitor. Proin dapibus in nunc eu commodo. Morbi bibendum ligula sit amet metus porttitor, ut posuere ipsum eleifend. Etiam fermentum libero nisl, id bibendum tortor dapibus vel. Donec consequat sapien eu auctor gravida. Morbi semper augue et interdum placerat. Fusce ullamcorper rutrum consectetur. Maecenas condimentum magna quis volutpat tempor. Ut a placerat sapien. Aliquam malesuada eu nibh vitae cursus. Nam in nibh et metus tempus porttitor. Pellentesque commodo sit amet enim eget malesuada. Curabitur ut pulvinar tortor, vitae porta sem.Phasellus mattis et elit quis maximus. Fusce mollis ornare est, ac lacinia felis eleifend eget. Donec placerat mauris dictum ligula consequat eleifend. Phasellus interdum consectetur tellus, eget ornare nisl dictum at. Nam vulputate erat viverra consectetur iaculis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Phasellus eu elit ornare, vestibulum lacus sit amet, rutrum orci. Nam et sodales erat. Nunc pharetra, massa nec bibendum faucibus, sem augue pulvinar sem, a ultrices metus est sed erat. Nullam faucibus neque a eleifend tincidunt. Donec gravida magna quis est dignissim volutpat.Phasellus quis sapien vitae arcu ultrices tempor vel sit amet neque. Donec mattis tellus id tortor eleifend laoreet vel nec felis. Duis sem ligula, facilisis eget fringilla quis, tincidunt non eros. Donec bibendum purus nec fermentum porttitor. Donec a scelerisque lacus. Praesent nec hendrerit risus. Pellentesque non accumsan nibh, in semper lacus. Vestibulum metus felis, dapibus in metus vel, imperdiet elementum risus. Vestibulum vehicula convallis aliquam. Pellentesque vestibulum nunc id ipsum feugiat, ac sagittis nibh ultricies. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Integer in aliquam ex.Mauris ipsum augue, lacinia id rhoncus a, scelerisque vitae orci. Duis dapibus metus eget risus pulvinar placerat. Donec vitae justo pretium, sagittis ligula eu, cursus sapien. Mauris rhoncus dictum posuere. Integer pellentesque egestas massa, sed cursus mi elementum dictum. Donec eget elit ac ipsum cursus porttitor. Cras sagittis, ex ac ultrices molestie, mi lacus fringilla diam, ut tempor sapien eros ut lectus. Vivamus sollicitudin augue id leo rutrum vestibulum in eget metus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos."
	
	local lotsOfTextObject = display.newText ( lotsOfText, 0, 0, 300, 0, "Helvetica", 14)
	lotsOfTextObject:setTextColor(0)
	lotsOfTextObject.x = centerX
	lotsOfTextObject.y = underScore.y + 650
	
	local example = display.newImage("example.png")
		example:translate( lotsOfTextObject.x , lotsOfTextObject.y + 750 )
	 
	scrollView:insert(lotsOfTextObject)
	scrollView:insert(example)
	
	sceneGroup:insert(scrollView)

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
