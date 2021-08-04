-- =============================================================
-- Standard.lua
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

----------------------------------------------------------------------
--	Scene Methods
----------------------------------------------------------------------

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:create(event)
	local sceneGroup = self.view
	local subject = event.params.subjects

	local topBar = display.newRect(sceneGroup, centerX, centerY - 260, fullw + 5, 50)
	topBar:setFillColor(224/255,102/255,102/255)
	topBar.strokeWidth = 3
	topBar:setStrokeColor(0, 0, 0)
	
	local title = display.newText(sceneGroup, subject, centerX , topBar.y, native.systemFontBold, 24)
	title:setFillColor(0,0,0)

	local function handleButtonEvent( event )
		if ( "ended" == event.phase ) then
			print( "Button was pressed and released" )
			local options = {
				effect = "slideRight",
				time = 750
			}
			composer.gotoScene("scenes.screens.drills", options)	
		end
	end
	
	-- Create the widget
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
	
	local function scrollListener(event)
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
		top = 7,
		width = fullw,
		height = fullh + 40,
		horizontalScrollDisabled = true,
		verticalScrollDisabled = false,
		isBounceEnabled = true,
		hideBackground = true,
		listener = scrollListener,
	}
	
	local lotsOfText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sodales, justo et lobortis sodales, nisl ante euismod diam, fringilla pulvinar nisl ante ac nisi. Fusce sem tellus, pharetra facilisis elementum quis, blandit ut augue. Integer vel magna eget eros feugiat aliquam sed convallis magna. Etiam luctus leo lacinia magna elementum elementum. Nunc rhoncus purus eu volutpat posuere. Nunc commodo feugiat velit in dapibus. Integer lacinia interdum congue. In pharetra malesuada ex in porttitor. Proin dapibus in nunc eu commodo. Morbi bibendum ligula sit amet metus porttitor, ut posuere ipsum eleifend. Etiam fermentum libero nisl, id bibendum tortor dapibus vel. Donec consequat sapien eu auctor gravida. Morbi semper augue et interdum placerat. Fusce ullamcorper rutrum consectetur. Maecenas condimentum magna quis volutpat tempor. Ut a placerat sapien. Aliquam malesuada eu nibh vitae cursus. Nam in nibh et metus tempus porttitor. Pellentesque commodo sit amet enim eget malesuada. Curabitur ut pulvinar tortor, vitae porta sem.Phasellus mattis et elit quis maximus. Fusce mollis ornare est, ac lacinia felis eleifend eget. Donec placerat mauris dictum ligula consequat eleifend. Phasellus interdum consectetur tellus, eget ornare nisl dictum at. Nam vulputate erat viverra consectetur iaculis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Phasellus eu elit ornare, vestibulum lacus sit amet, rutrum orci. Nam et sodales erat. Nunc pharetra, massa nec bibendum faucibus, sem augue pulvinar sem, a ultrices metus est sed erat. Nullam faucibus neque a eleifend tincidunt. Donec gravida magna quis est dignissim volutpat.Phasellus quis sapien vitae arcu ultrices tempor vel sit amet neque. Donec mattis tellus id tortor eleifend laoreet vel nec felis. Duis sem ligula, facilisis eget fringilla quis, tincidunt non eros. Donec bibendum purus nec fermentum porttitor. Donec a scelerisque lacus. Praesent nec hendrerit risus. Pellentesque non accumsan nibh, in semper lacus. Vestibulum metus felis, dapibus in metus vel, imperdiet elementum risus. Vestibulum vehicula convallis aliquam. Pellentesque vestibulum nunc id ipsum feugiat, ac sagittis nibh ultricies. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Integer in aliquam ex.Mauris ipsum augue, lacinia id rhoncus a, scelerisque vitae orci. Duis dapibus metus eget risus pulvinar placerat. Donec vitae justo pretium, sagittis ligula eu, cursus sapien. Mauris rhoncus dictum posuere. Integer pellentesque egestas massa, sed cursus mi elementum dictum. Donec eget elit ac ipsum cursus porttitor. Cras sagittis, ex ac ultrices molestie, mi lacus fringilla diam, ut tempor sapien eros ut lectus. Vivamus sollicitudin augue id leo rutrum vestibulum in eget metus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos."
	
	local lotsOfTextObject = display.newText(lotsOfText, 0, 0, 300, 0, "Helvetica", 14)
	lotsOfTextObject:setTextColor(0)
	lotsOfTextObject.x = centerX
	lotsOfTextObject.y = scrollView.y + 255
	
	local example = display.newImage("images/example.png", centerX, lotsOfTextObject.y + 690)

	scrollView:insert(lotsOfTextObject)
	scrollView:insert(example)
	sceneGroup:insert(scrollView)
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
