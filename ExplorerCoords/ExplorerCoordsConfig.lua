local config = CreateFrame("Frame");
ExplorerCoordsConfig = config;
function config:SetDefaultConfig()
	ExplorerCoords_Config = {};
	ExplorerCoords_Config.ShowWorldMap = 1;
	ExplorerCoords_Config.ShowMiniMap = 0;
	config.ShowOnMainMap:SetChecked(1);
	config.ShowOnMiniMap:SetChecked(0);

end

function config:SetCurrentConfig()
	config.ShowOnMainMap:SetChecked(ExplorerCoords_Config.ShowWorldMap);
	config.ShowOnMiniMap:SetChecked(ExplorerCoords_Config.ShowMiniMap);
end

function config:ChangeState()
	
	 ExplorerCoords_Config[self.id] = self:GetChecked() or 0;
	if(self.id == "ShowWorldMap") then
		if(self:GetChecked() == 1) then
			ExplorerCoordsFrame:RegisterEvent("WORLD_MAP_UPDATE");
		else
			ExplorerCoordsFrame:UnregisterEvent("WORLD_MAP_UPDATE");
			ExplorerCoords_ClearNotes("world");
		end
	elseif(self.id == "ShowMiniMap") then
		if(self:GetChecked() == 1) then
			ExplorerCoordsFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA");
			ExplorerCoords_UpdateMap("mini");
		else
			ExplorerCoordsFrame:UnregisterEvent("ZONE_CHANGED_NEW_AREA");
			ExplorerCoords_ClearNotes("mini");
		end
	end
end

function config:Init()

	config.name = "Explorer Coords";

 
 local ShowOnMainMap = CreateFrame( "CheckButton", "ShowOnMainMapCheckBox", config, "InterfaceOptionsCheckButtonTemplate" );
	config.ShowOnMainMap = ShowOnMainMap;
	ShowOnMainMap.id = "ShowWorldMap";
	ShowOnMainMap:SetPoint( "TOPLEFT", 16, -16 );
	ShowOnMainMap:SetScript("onClick",config.ChangeState);
	_G[ ShowOnMainMap:GetName().."Text" ]:SetText( EXPLORER_COORD_OPTION_WORLDMAP );
 
  local ShowOnMiniMap = CreateFrame( "CheckButton", "ShowOnMiniMapCheckBox", config, "InterfaceOptionsCheckButtonTemplate" );
    config.ShowOnMiniMap = ShowOnMiniMap;
	ShowOnMiniMap.id = "ShowMiniMap";
	ShowOnMiniMap:SetPoint( "TOPLEFT", ShowOnMainMap, "BOTTOMLEFT", 0, -16);
	ShowOnMiniMap:SetScript("onClick",config.ChangeState);
	_G[ ShowOnMiniMap:GetName().."Text" ]:SetText( EXPLORER_COORD_OPTION_MINIMAP );

	local ExplorerLabelName = config:CreateFontString( nil, "ARTWORK", "GameFontHighlightSmall" );
	config.ExplorerLabelName = ExplorerLabelName;
	ExplorerLabelName:SetPoint( "TOPLEFT",  ShowOnMiniMap, "BOTTOMLEFT", 0, -16);
	ExplorerLabelName:SetText( "Powered by |c19ff0800WoWUse.com" );
 
 	local ExplorerEditBoxID = CreateFrame( "EditBox", "ExplorerEditBoxIDEditBox", config, "InputBoxTemplate" );
	config.ExplorerEditBoxID = ExplorerEditBoxID;
	ExplorerEditBoxID.id = "ExplorerEditBoxID";
	ExplorerEditBoxID:SetPoint( "TOPLEFT",  ExplorerLabelName, "BOTTOMLEFT", 0, -16);
	ExplorerEditBoxID:SetWidth(200);
	ExplorerEditBoxID:SetHeight(50);
	ExplorerEditBoxID:SetAutoFocus( false );
	ExplorerEditBoxID:SetScript( "OnEditFocusGained", function () this:HighlightText(0); end );
	ExplorerEditBoxID:SetScript( "OnShow", function () this:SetText("http://www.wowuse.com"); end );
	ExplorerEditBoxID:SetScript( "OnChar", function () this:SetText("http://www.wowuse.com");this:HighlightText(0); end );
 
 InterfaceOptions_AddCategory(config);
 
 if not (ExplorerCoords_Config) then
   config:SetDefaultConfig();
 else
   config:SetCurrentConfig();
 end
 if (ExplorerCoords_Config.ShowMiniMap == 1) then
	ExplorerCoordsFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	ExplorerCoords_UpdateMap("mini");
 end
 if (ExplorerCoords_Config.ShowWorldMap == 1) then
	ExplorerCoordsFrame:RegisterEvent("WORLD_MAP_UPDATE");
 end
 

end