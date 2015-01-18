--[[

  ______                _                    _                         _     
 |  ____|              | |                  | |                       | |    
 | |__   __ _ ___ _   _| |     __ ___      _| |__   ___   __ _ _ __ __| |___ 
 |  __| / _` / __| | | | |    / _` \ \ /\ / / '_ \ / _ \ / _` | '__/ _` / __|
 | |___| (_| \__ \ |_| | |___| (_| |\ V  V /| |_) | (_) | (_| | | | (_| \__ \
 |______\__,_|___/\__, |______\__,_| \_/\_/ |_.__/ \___/ \__,_|_|  \__,_|___/
                   __/ |                                                     
                  |___/        
				  
	Created by Adzter: http://steamcommunity.com/id/imadzter
	For NPIGamers: http://npigamers.com/
	
--]]

-- Create the initial panel
function openLaws()
	local mainPanel = vgui.Create( "DFrame" )
	mainPanel:SetSize( 500, 275 )
	mainPanel:Center()
	mainPanel:SetTitle( " " )
	mainPanel.Paint = function()
		draw.RoundedBox( 0, 0, 0, mainPanel:GetWide(), mainPanel:GetTall(), Color( 240, 240, 240 ) )
		draw.RoundedBox( 0, 0, 0, mainPanel:GetWide(), 25, Color( 39, 174, 96) )
		draw.SimpleText( "Law Menu", "Trebuchet18", mainPanel:GetWide()/2, 3, Color(255,255,255), TEXT_ALIGN_CENTER, 0 )
	end
	
	-- The list that holds all the items
	local mainList = vgui.Create( "DListView", mainPanel )
	mainList:SetMultiSelect( false )
	mainList:SetHideHeaders( true )
	mainList:SetSize( mainPanel:GetWide(), mainPanel:GetTall() - 25 )
	mainList:SetPos( 0, 25 )
	
	mainList:AddColumn( "Law Item" )
	
	local textEntry = vgui.Create( "DTextEntry", mainPanel )
	textEntry:SetPos( 0, mainPanel:GetTall() - 25 )
	textEntry:SetSize( mainList:GetWide() - 150, 25 )
	textEntry:SetText( "Enter law here" )
	
	local addButton = vgui.Create( "DButton", mainPanel )
	addButton:SetPos( 349, mainPanel:GetTall() - 25 )
	addButton:SetSize( 76, 25 )
	addButton:SetText( "Add" )
	addButton.DoClick = function()
		if string.len( textEntry:GetValue() ) > 0 and textEntry:GetValue() != "Enter law here" then
			LocalPlayer():ConCommand( "say /addlaw " .. textEntry:GetValue() )
		end
		
		-- Clear the list of laws ready to reload
		mainList:Clear()
		
		-- Now lets reload all the laws
		-- We need a small delay because of the time it takes to run the DarkRP commands
		timer.Simple( 0.1, function() 
			--Get all DarkRP laws and add them to the list
			for k,v in pairs( DarkRP.getLaws() ) do
				mainList:AddLine( v )
			end
			textEntry:SetText( "Enter law here" )
		end )
	end
	
	local removeButton = vgui.Create( "DButton", mainPanel )
	removeButton:SetPos( 424, mainPanel:GetTall() - 25 )
	removeButton:SetSize( 75, 25 )
	removeButton:SetText( "Remove" )
	removeButton.DoClick = function()
	
		-- Make sure sure we have something selected
		if mainList:GetSelectedLine() then
			LocalPlayer():ConCommand( "say /removelaw " .. mainList:GetSelectedLine() )
		
			-- Clear the list of laws ready to reload
			mainList:Clear()
			
			-- Now lets reload all the laws
			-- We need a small delay because of the time it takes to run the DarkRP commands
			timer.Simple( 0.1, function() 
				--Get all DarkRP laws and add them to the list
				for k,v in pairs( DarkRP.getLaws() ) do
					mainList:AddLine( v )
				end
				textEntry:SetText( "Enter law here" )
			end )
		end
	end
	
	-- Get all DarkRP laws and add them to the list
	for k,v in pairs( DarkRP.getLaws() ) do
		mainList:AddLine( v )
	end
	
	mainPanel:MakePopup()
end
