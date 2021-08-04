-- AS 91373 Programming Assessment
-- [Matthew Young]
-- [91373: Construct an advanced computer program for a specified task (Charactor Creation)]]

-- =============================================================
-- main.lua
-- =============================================================

----------------------------------------------------------------------
--	1. Requires
----------------------------------------------------------------------
-- Require the Widget Library
local widget = require( "widget" )

----------------------------------------------------------------------
--	2. Constants
----------------------------------------------------------------------
-- Create constants to make coding more efficent later on
local centerX = display.contentCenterX
local centerY = display.contentCenterY
local width = display.contentWidth
local height = display.contentHeight

----------------------------------------------------------------------
--	3. Variables
----------------------------------------------------------------------
-- Create tables to hold user choices
-- Scoped for the whole file so that all functions can access it
local faceChoice = {}
local hairChoice = {}
local pantsChoice = {}
local shirtChoice = {}
local shoesChoice = {}

----------------------------------------------------------------------
--	4. Functions
----------------------------------------------------------------------

-- Function to create the 5 different clothes picker buttons and text
local function createClothesPicker(group, faceTable, hairTable, pantsTable, shirtTable, shoesTable)
	-- Display left and right arrows that can be used to scroll through the different options of the table
	-- Display text between the two buttons that show the currently chosen clothing
	
	-- Counters to keep track of chosen clothes
	
	-- Chosen values will have to be stored in a table (like "foodChoice" in the food example) that is scoped correctly
	-- Make sure display objects are inserted into the correct group

	-- Receives:
		-- A reference to the group it will be stored in
		-- Tables containing a list of things that can be chosen


	-- Display clothing texts for pickers that shows the current selections
	-- Display text for Face, Hair, Pants, Shirt and Shoes
	local faceText = display.newText(group, faceTable[1], centerX, centerY - 400, native.systemFont, 36 )
	local hairText = display.newText(group, hairTable[1], centerX, centerY - 300, native.systemFont, 36 )
	local pantsText = display.newText(group, pantsTable[1], centerX, centerY - 200, native.systemFont, 36 )
	local shirtText = display.newText(group, shirtTable[1], centerX, centerY - 100, native.systemFont, 36 )
	local shoesText = display.newText(group, shoesTable[1], centerX, centerY, native.systemFont, 36 )
	
	-- Initialize variables for each clothing, called counter and set it to 1
	local faceCounter = 1
	local hairCounter = 1
	local pantsCounter = 1
	local shirtCounter = 1
	local shoesCounter = 1
	
	-- Make clothing choices[1] equal the first element of the table that was passed over
	faceChoice[1] = faceTable[1]
	hairChoice[1] = hairTable[1]
	pantsChoice[1] = pantsTable[1]
	shirtChoice[1] = shirtTable[1]
	shoesChoice[1] = shoesTable[1]

	
	-- HandleButtonEvents for each clothing choices to scroll through the tables and
	-- Create the left and right buttons for each clothing choices to choose desired options
------------------------------------------------------------------------------------------------------
------------------------------FACE--------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
	local function faceHandleButtonEvent (event)
		-- Check if the id of the event is Left or Right
		-- If Left then subtract 1 from the counter and update the text to show the new value
		-- If Right then add 1 from the counter and update the text to show the new value
		
		if event.target.id == "Left" then
		-- If left then subtract 1 from faceCounter
			faceCounter = faceCounter - 1
		-- If faceCounter = 0, meaning it is scrolling down from the first option then loop back up to the last option
			if (faceCounter == 0) then
				faceCounter = 5
			end
		-- Update the clothing text
			faceText.text = faceTable[faceCounter]
			
		elseif event.target.id == "Right" then
		-- If right then add 1 to faceCounter
			faceCounter = faceCounter + 1
		-- If faceCounter = 6, meaning it is going past the last option then loop back down to the first option
			if (faceCounter == 6) then
				faceCounter = 1
			end
		-- Update the clothing text
			faceText.text = faceTable[faceCounter]
		end
		-- Update the value stored in the main table
		faceChoice[1] = faceTable[faceCounter]
	end
	
	-- Display two buttons, an arrow on the left to scroll text left and
	-- An arrow on the right to scroll text right
	-- Align the arrows in the correct place on the screen and insert them into the appropriate group
	
	-- Create Left Button for face
	-- Align it and insert it into the group
	local faceLButton = widget.newButton(
    {
        left = 0,
        top = 0,
        id = "Left",
        label = "Left",
        radius = 30,
        shape = "circle",
        fillColor = { default={0,1,0,1}, over={0,1,0,0.8} },
        onRelease = faceHandleButtonEvent
    })
	faceLButton.y = centerY - 400
	faceLButton.x = centerX - 200
	group:insert(faceLButton)
	
	-- Create Right Button for face
	-- Align it and insert it into the group
	local faceRButton = widget.newButton(
    {
        left = 0,
        top = 0,
        id = "Right",
        label = "Right",
        radius = 30,
        shape = "circle",
        fillColor = { default={0,1,0,1}, over={0,1,0,0.8} },
        onRelease = faceHandleButtonEvent
    })
	faceRButton.y = centerY - 400
	faceRButton.x = centerX + 200
	group:insert(faceRButton)


------------------------------------------------------------------------------------------------------
------------------------------HAIR--------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
	local function hairHandleButtonEvent(event)
		-- Check if the id of the event is Left or Right
		-- If Left then subtract 1 from the counter and update the text to show the new value
		-- If Right then add 1 from the counter and update the text to show the new value
	
		if event.target.id == "Left" then
		-- If left then subtract 1 from hairCounter
			hairCounter = hairCounter - 1
		-- If hairCounter = 0, meaning it is scrolling down from the first option then loop back up to the last option
			if (hairCounter == 0) then
				hairCounter = 4
			end
			-- Update the counter value
			hairText.text = hairTable[hairCounter]

		elseif event.target.id == "Right" then
		-- If Right then add 1 to hairCounter
			hairCounter = hairCounter + 1
		-- If hairCounter = 5, meaning it is going past the last option then loop back down to the first option
			if (hairCounter == 5) then
				hairCounter = 1
			end
		-- Update the counter value
			hairText.text = hairTable[hairCounter]
		end
		-- Update the value stored in the main table
		hairChoice[1] = hairTable[hairCounter]
	end
	
	-- Display two buttons, an arrow on the left to scroll text left and
	-- An arrow on the right to scroll text right
	-- Allign the arrows in the correct place on the screen and insert them into the appropriate group
	
	-- Create Left Button for hair
	-- Align it and insert it into the group
	local hairLButton = widget.newButton(
    {
        left = 0,
        top = 0,
        id = "Left",
        label = "Left",
        radius = 30,
        shape = "circle",
        fillColor = { default={0,1,0,1}, over={0,1,0,0.8} },
        onRelease = hairHandleButtonEvent
    })
	hairLButton.y = centerY - 300
	hairLButton.x = centerX - 200
	group:insert(hairLButton)
	
	-- Create Right Button for hair
	-- Align it and insert it into the group
	local hairRButton = widget.newButton(
    {
        left = 0,
        top = 0,
        id = "Right",
        label = "Right",
        radius = 30,
        shape = "circle",
        fillColor = { default={0,1,0,1}, over={0,1,0,0.8} },
        onRelease = hairHandleButtonEvent
    })
	hairRButton.y = centerY - 300
	hairRButton.x = centerX + 200
	group:insert(hairRButton)


------------------------------------------------------------------------------------------------------
------------------------------PANTS--------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
local function pantsHandleButtonEvent(event)
		-- Check if the id of the event is Left or Right
		-- If Left then subtract 1 from the counter and update the text to show the new value
		-- If Right then add 1 from the counter and update the text to show the new value
		
		if event.target.id == "Left" then
		-- If left then subtract 1 from pantsCounter
			pantsCounter = pantsCounter - 1
		-- If pantsCounter = 0, meaning it is scrolling down from the first option then loop back up to the last option
			if (pantsCounter == 0) then
				pantsCounter = 3
			end
			-- Update the counter value
			pantsText.text = pantsTable[pantsCounter]

		elseif event.target.id == "Right" then
		-- If Right then add 1 to pantsCounter
			pantsCounter = pantsCounter + 1
		-- If pantsCounter = 4, meaning it is going past the last option then loop back down to the first option		
			if (pantsCounter == 4) then
				pantsCounter = 1
			end
		-- Update the counter value
			pantsText.text = pantsTable[pantsCounter]
		end
		-- Update the value stored in the main table
		pantsChoice[1] = pantsTable[pantsCounter]
	end
	
	-- Display two buttons, an arrow on the left to scroll text left and
	-- An arrow on the right to scroll text right
	-- Allign the arrows in the correct place on the screen and insert them into the appropriate group
	
	-- Create Left Button for pants
	-- Align it and insert it into the group
	local pantsLButton = widget.newButton(
    {
        left = 0,
        top = 0,
        id = "Left",
        label = "Left",
        radius = 30,
        shape = "circle",
        fillColor = { default={0,1,0,1}, over={0,1,0,0.8} },
        onRelease = pantsHandleButtonEvent
    })
	pantsLButton.y = centerY - 200
	pantsLButton.x = centerX - 200
	group:insert(pantsLButton)
	
	-- Create Right Button for pants
	-- Align it and insert it into the group
	local pantsRButton = widget.newButton(
    {
        left = 0,
        top = 0,
        id = "Right",
        label = "Right",
        radius = 30,
        shape = "circle",
        fillColor = { default={0,1,0,1}, over={0,1,0,0.8} },
        onRelease = pantsHandleButtonEvent
    })
	pantsRButton.y = centerY - 200
	pantsRButton.x = centerX + 200
	group:insert(pantsRButton)


------------------------------------------------------------------------------------------------------
------------------------------SHIRT--------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
local function shirtHandleButtonEvent(event)
		-- Check if the id of the event is Left or Right
		-- If Left then subtract 1 from the counter and update the text to show the new value
		-- If Right then add 1 from the counter and update the text to show the new value
	
		if event.target.id == "Left" then
		-- If left then subtract 1 from shirtCounter
			shirtCounter = shirtCounter - 1
		-- If shirtCounter = 0, meaning it is scrolling down from the first option then loop back up to the last option
			if (shirtCounter == 0) then
				shirtCounter = 3
			end
			-- Update the counter value
			shirtText.text = shirtTable[shirtCounter]

		elseif event.target.id == "Right" then
		-- If Right then add 1 to shirtCounter
			shirtCounter = shirtCounter + 1
		-- If shirtCounter = 4, meaning it is going past the last option then loop back down to the first option
			if (shirtCounter == 4) then
				shirtCounter = 1
			end
			-- Update the counter value
			shirtText.text = shirtTable[shirtCounter]
		end
		-- Update the value stored in the main table
		shirtChoice[1] = shirtTable[shirtCounter]
	end
	
	-- Display two buttons, an arrow on the left to scroll text left and
	-- An arrow on the right to scroll text right
	-- Allign the arrows in the correct place on the screen and insert them into the appropriate group
	
	-- Create Left Button for shirt
	-- Align it and insert it into the group
	local shirtLButton = widget.newButton(
    {
        left = 0,
        top = 0,
        id = "Left",
        label = "Left",
        radius = 30,
        shape = "circle",
        fillColor = { default={0,1,0,1}, over={0,1,0,0.8} },
        onRelease = shirtHandleButtonEvent
    })
	shirtLButton.y = centerY - 100
	shirtLButton.x = centerX - 200
	group:insert(shirtLButton)
	
	-- Create Right Button for shirt
	-- Align it and insert it into the group
	local shirtRButton = widget.newButton(
    {
        left = 0,
        top = 0,
        id = "Right",
        label = "Right",
        radius = 30,
        shape = "circle",
        fillColor = { default={0,1,0,1}, over={0,1,0,0.8} },
        onRelease = shirtHandleButtonEvent
    })
	shirtRButton.y = centerY - 100
	shirtRButton.x = centerX + 200
	group:insert(shirtRButton)


------------------------------------------------------------------------------------------------------
------------------------------SHOES-------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
local function shoesHandleButtonEvent(event)
		-- Check if the id of the event is Left or Right
		-- If Left then subtract 1 from the counter and update the text to show the new value
		-- If Right then add 1 from the counter and update the text to show the new value
		
		if event.target.id == "Left" then
		-- If left then subtract 1 from shoesCounter
			shoesCounter = shoesCounter - 1
		-- If shoesCounter = 0, meaning it is scrolling down from the first option then loop back up to the last option
			if (shoesCounter == 0) then
				shoesCounter = 3
			end
			-- Update the counter value
			shoesText.text = shoesTable[shoesCounter]

		elseif event.target.id == "Right" then
		-- If Right then add 1 to shoesCounter
			shoesCounter = shoesCounter + 1
		-- If shoesCounter = 4, meaning it is going past the last option then loop back down to the first option
			if (shoesCounter == 4) then
				shoesCounter = 1
			end
		-- Update the counter value
			shoesText.text = shoesTable[shoesCounter]
		end
		-- Update the value stored in the main table
		shoesChoice[1] = shoesTable[shoesCounter]
	end
	
	-- Display two buttons, an arrow on the left to scroll text left and
	-- An arrow on the right to scroll text right
	-- Allign the arrows in the correct place on the screen and insert them into the appropriate group
	
	-- Create Left Button for shoes
	-- Align it and insert it into the group
	local shoesLButton = widget.newButton(
    {
        left = 0,
        top = 0,
        id = "Left",
        label = "Left",
        radius = 30,
        shape = "circle",
        fillColor = { default={0,1,0,1}, over={0,1,0,0.8} },
        onRelease = shoesHandleButtonEvent
    })
	shoesLButton.y = centerY 
	shoesLButton.x = centerX - 200
	group:insert(shoesLButton)
	
	-- Create Right Button for shoes
	-- Align it and insert it into the group
	local shoesRButton = widget.newButton(
    {
        left = 0,
        top = 0,
        id = "Right",
        label = "Right",
        radius = 30,
        shape = "circle",
        fillColor = { default={0,1,0,1}, over={0,1,0,0.8} },
        onRelease = shoesHandleButtonEvent
    })
	shoesRButton.y = centerY
	shoesRButton.x = centerX + 200
	group:insert(shoesRButton)

	
--------------------------------------------------------------------------------------------------------
----------------------------Reset Button for Picker Options---------------------------------------------
---------------------------------Excellence Extension---------------------------------------------------
--------------------------------------------------------------------------------------------------------

-- Function for the Picker Reset Button - if clicked, reset all picker.text back to their original table counters
-- Reset all picker.text back to [1] and show an alert that all picker options have been reset 
local function resetHandleButtonEvent(event)
	if ( "ended" == event.phase ) then
		faceText.text = faceTable[1]
		hairText.text = hairTable[1]
		pantsText.text = pantsTable[1]
		shirtText.text = shirtTable[1]
		shoesText.text = shoesTable[1]
		local alert = native.showAlert( "Reset", "All Picker Options Reset", {"OK"}, resetHandleButtonEvent )
	end
end
 
	-- Create the Reset Button
	-- Align it and insert it into the group
	local resetButton = widget.newButton(
		{
        id = "resetButton",
        label = "Reset",
        radius = 30,
        shape = "roundedRectangle",
        fillColor = { default={0,1,0,1}, over={0,1,0,0.8} },
        onRelease = resetHandleButtonEvent
    })
	resetButton.y = faceText.y - 80
	resetButton.x = centerX
	group:insert(resetButton)
end


-- Function to Display textField and "Enter Strength"
local function createTextBox(group)
	-- Display text on screen "Enter Strength"
	-- Display a textField to enter in desired strength value

	-- Receives:
		-- Group - group to store the textField into
	
	-- Returns:
		-- textField - a reference to the textField so we can access its contents later
	
	-- Display text on screen "Enter Strength"
	-- Insert it into the group
	local enterStrengthText = display.newText( "Enter Strength", centerX, 600, native.systemFont, 24 )
		enterStrengthText:setFillColor( 1, 1, 1 )
		group:insert(enterStrengthText)
	
	-- Display textField on screen
	-- Align and insert it into group
	local textField = native.newTextField( 0, 0, 175, 40 )
		textField.x = centerX
		textField.y = enterStrengthText.y + 40
		group:insert(textField)
	
	-- Return the Textfield
	return textField
end


-- Function to display/align the dressed character, display text "Your Character" and calculate and display hitPoints
local function displayMan(textField)
	-- Create a new group to display the finished "dressed man"
	-- Display some text about the character
	-- Draw the man's body and then place the appropriate clothing on the man
	-- Make sure each of these items are placed correctly on the screen
	-- Calculate and display the characters hitPoints (strength*10/1.3)

	-- Receives:
		-- A reference to the table containing all the chosen / entered data
	
	-- Create group to store the 2nd screen
	local group = display.newGroup()
	
	-- Display the text "Your Character"
	local yourCharacterText = display.newText( "Your Character", centerX, centerY - 450, native.systemFont, 36 )
	yourCharacterText:setFillColor( 1, 1, 1 )
	
	-- Function to take the strength value entered (textField.text) and
	-- Apply the (*10/1.3) formula to calculate and return hitpoints
	local function calculateHitPoints(strength)
		-- Calculates character hitpoints
	
		-- Recieves:
		-- The value of strength entered
	
		-- Returns:
		-- Strength to a full rounded number

	
		-- Return hitpoints (strength*10/1.3)
			-- math.floor(rounds the number down)
			-- math.round(rounds the number up)
		return math.round(strength*10/1.3)
	end

	-- Display the text "Your hitpoints = (hitpoints)" 
	local displayHitPoints = display.newText (group, "Your hitpoints = " .. calculateHitPoints(textField.text), centerX, centerY + 250, native.systemFont, 36)


	--------------------------------------------------------------------------------------
	----------------------Display the Character and Clothes-------------------------------
	--------------------------------------------------------------------------------------
	
	-- Display body template first so it is on the bottom "layer",
	-- Then display face before hair so the hair goes over the face "layer"
	-- Display shoes before pants so the pants goes over the shoes "layer" - like how it is in real-life
	-- Finally, display shirt last as it should over the pants
	
	-- Display the body template
	local body = display.newImage(group, "body.png", 0,0)
	body.x = centerX
	body.y = centerY - 30
	
	-- Display the facial expression chosen through faceChoice[faceCounter]
	local face = display.newImage(group, faceChoice[1]..".png",0,0)
	face.x = centerX 
	face.y = body.y - 260
	
	-- Display the hair chosen through hairChoice[hairCounter]
	local hair = display.newImage(group, hairChoice[1]..".png",0,0)
	hair.x = centerX 
	hair.y = face.y - 55
	
	-- Display the shoes chosen through shoesChoice[shoesCounter]
	local shoes = display.newImage(group, shoesChoice[1]..".png",0,0)
	shoes.x = centerX - 48
	shoes.y = body.y + 200
	
	-- Display the pants chosen through pantsChoice[pantsCounter]
	local pants = display.newImage(group, pantsChoice[1]..".png",0,0)
	pants.x = centerX + 5
	pants.y = body.y + 60
	
	-- Display the shirt chosen through shirtChoice[shirtCounter]
	local shirt = display.newImage(group, shirtChoice[1]..".png",0,0)
	shirt.x = centerX 
	shirt.y = body.y - 95

end



local function selectButton(group, textField)
	-- Display a button that when pressed will:
		-- Validate the text fields to make sure the text is all OK
		-- If not then show an appropriate error message
		-- Remove the current group
		-- Call the function that displays the man (displayMan)
		-- Insert the button into the appropriate group

	-- Receives:
		-- a reference to the group to insert the button into
		-- a reference to text field(s) so they can be validated

	local function strengthHandleButtonEvent(event)
		-- Do data validation on (textField.text)
		-- If the text is not correct then
		-- Display an alert
		
		-- Check if textField.text is empty
		-- If empty, show alert
		if textField.text == "" then
			local alert = native.showAlert( "Error", "Please Enter a Value", {"OK"} )
		-- Check if textField.text are numbers
		-- If not, show alert
		elseif tonumber(textField.text) == nil then
			local alert = native.showAlert( "Error", "Must be a Number", {"OK"} )
		-- Check if textField.text is over 100
		-- If over 100, show alert
		elseif tonumber(textField.text) > 100 then
			local alert = native.showAlert( "1-100", "Please Enter Numbers Between 1-100", {"OK"} )
		-- Check textField.text is equal or below 0
		elseif tonumber(textField.text) <= 0 then
			local alert = native.showAlert( "1-100", "Must Be A Positive Number", {"OK"} )
		else
			display.remove(group)
			displayMan(textField)
		end
	end
	
	-- Create a button with the text "Finish" and have it call strengthHandleButtonEvent when clicked
	local finishButton = widget.newButton(
    {
        left = 0,
        top = 0,
        label = "Finish",
        radius = 20,
        shape = "roundedRect",
        fillColor = { default={1,1,1,1}, over={0,1,1,0.8} },
        onRelease = strengthHandleButtonEvent
    })
	
	-- Align the button correctly on the screen and insert it ino the right group
	finishButton.x = centerX
	finishButton.y = textField.y + 150
	group:insert(finishButton)
end


-- Function that makes a group, tables for all clothes, call createClothesPicker,
-- Create the textField variable and call selectButton
local function mainLoop ()
	-- Create a group to put all your objects in
	-- Create tables for all the clothing items
	-- Call the function(s) that create the pickers
	-- Call the function(s) that create the textField
	-- Call the function that created the "Finish" button

	-- Receives: nil
	-- Returns: nil
	
	-- Create a new group
	local group = display.newGroup()
	
	-- Create tables for all the clothes, with all the clothing options in it
	-- Face, Hair, Pants, Shirt, Shoes
	local faceTable = {"ecstatic", "happy", "scared", "smug", "surprised"}
	local hairTable = {"hat", "headphones", "mowhawk", "straight"}
	local pantsTable = {"3quarter", "cargo", "jeans"}
	local shirtTable = {"jacket", "singlet", "t-shirt"}
	local shoesTable = {"converse", "jandles", "loafers"}
	
	-- Call createClothesPicker and pass over the display group, faceTable, hairTable, pantsTable, shirtTable, shoesTable
	createClothesPicker(group,faceTable, hairTable, pantsTable, shirtTable, shoesTable)
	-- Call createTextBox and pass over the display group and then store the returned value in textField
	local textField = createTextBox(group)
	-- Call selectButton and pass over the display group and textField
	selectButton(group, textField)
end

-- Call the function mainLoop
mainLoop()