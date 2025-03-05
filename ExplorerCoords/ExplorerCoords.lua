Exp_ZoneNames = {};
local Exp_Targets = {};
local Exp_TargetsMini = {};
local lastmap="";
local showmissing = true;
ExplorerCoordsConfig = {};

local Astrolabe = DongleStub("Astrolabe-0.4");



function ExplorerCoords_OnLoad()
	--if not (ExplorerCoord) then
		--ExplorerCoords_Init();
	 --end
    ExplorerCoordsFrame:RegisterEvent("ADDON_LOADED");
	Exp_ZoneNames[1] = { GetMapZones(1) } ;
	Exp_ZoneNames[2] = { GetMapZones(2) } ;
	Exp_ZoneNames[3] = { GetMapZones(3) } ;
	Exp_ZoneNames[4] = { GetMapZones(4) } ;
	for i=1,30,1 do
	  Exp_Target=CreateFrame("Button", "ExplorerCoordsWorldTargetFrame",WorldMapDetailFrame );
	  Exp_Target:SetWidth(16);
      Exp_Target:SetHeight(16);
	  Exp_Target.icon = Exp_Target:CreateTexture("ARTWORK");
      Exp_Target.icon:SetAllPoints();
	  Exp_Target.icon:SetTexture("Interface\\AddOns\\ExplorerCoords\\images\\coordicon");
	  Exp_Target:SetFrameLevel(10000);
	  Exp_Target:EnableMouse(true);
	  Exp_Target:SetScript("OnEnter", ExplorerCoords_Coord_OnEnter);
	  Exp_Target:SetScript("OnLeave", ExplorerCoords_Coord_OnLeave);
	  Exp_Targets[i]=Exp_Target;
	end
	
	for i=1,30,1 do
	  Exp_TargetMini=CreateFrame("Button", "ExplorerCoordsMinimapTargetFrame",UIParent );
	  Exp_TargetMini:SetWidth(10);
      Exp_TargetMini:SetHeight(10);
	  Exp_TargetMini.icon = Exp_TargetMini:CreateTexture("ARTWORK");
      Exp_TargetMini.icon:SetAllPoints();
	  Exp_TargetMini.icon:SetTexture("Interface\\AddOns\\ExplorerCoords\\images\\coordicon");
	  Exp_TargetMini:SetFrameLevel(10000);
	  Exp_TargetMini:EnableMouse(true);
	  Exp_TargetMini:SetScript("OnEnter", ExplorerCoords_MiniCoord_OnEnter);
	  Exp_TargetMini:SetScript("OnLeave", ExplorerCoords_MiniCoord_OnLeave);
	  Exp_TargetsMini[i]=Exp_TargetMini;
	end
	--GetCurrentMapZone
	
end

function ExplorerCoords_Init()
	if not (ExplorerCoord ) then
		ExplorerCoord = {};
		for index,value in pairs(ExplorerCoordInit) do 
			for index2,value2 in pairs(value) do 
				parentzone=ExplorerCoords_GetZoneName(index,index2);
				ExplorerCoord[parentzone] = {};
				ExplorerCoord[parentzone]["catid"] = index2;
				for index3,value3 in pairs(value2) do 
					if(index2 == 868) then
						--ExplorerCoord[parentzone] = {};
					else
						subzone = ExplorerCoords_GetSubZoneName(index2,index3);
						ExplorerCoord[parentzone][subzone] = {};
						ExplorerCoord[parentzone][subzone]["x"] = value3["x"];
						ExplorerCoord[parentzone][subzone]["y"] = value3["y"];
					
					end
				end
			end
		end
	end
end

function  ExplorerCoords_GetZoneName(zoneindex,zoneid) 
	
	SetMapByID(ExplorerCoordMapIt[zoneindex][zoneid]); 
	return Exp_ZoneNames[GetCurrentMapContinent()][GetCurrentMapZone()];
	
	--for i=1,GetAchievementNumCriteria(zoneindex),1 do
		--zonename,_,_,_,_,_,_,zoneidingame,_,_=GetAchievementCriteriaInfo(zoneindex,i);
		--DEFAULT_CHAT_FRAME:AddMessage(zoneid);
		--if(zoneid==zoneidingame) then
			--DEFAULT_CHAT_FRAME:AddMessage("hjohoho");
		--	return zonename;
		--end
	--end

end

function  ExplorerCoords_GetSubZoneName(zoneindex,zoneid) 
	for i=1,GetAchievementNumCriteria(zoneindex),1 do
		zonename,_,_,_,_,_,_,zoneidingame,_,_=GetAchievementCriteriaInfo(zoneindex,i);
		--zonename,_,_,_,_,_,_,_,_,zoneidingame=GetAchievementCriteriaInfo(zoneindex,i);
		--DEFAULT_CHAT_FRAME:AddMessage(zoneid);
		if(zoneid==zoneidingame) then
			--DEFAULT_CHAT_FRAME:AddMessage("hjohoho");
			return zonename;
		end
	end

end

function ExplorerCoords_OnEvent()
	if ( (event == "WORLD_MAP_UPDATE") and WorldMapFrame:IsVisible() ) then
		ExplorerCoords_UpdateMap("world");
	elseif(event == "ZONE_CHANGED_NEW_AREA") then
		ExplorerCoords_UpdateMap("mini");
	
	elseif(event == "ADDON_LOADED") then
    if(arg1 == "ExplorerCoords") then
		ExplorerCoords_Init();
		ExplorerCoordsConfig:Init();
		ExplorerCoordsFrame:UnregisterEvent("ADDON_LOADED");
    end
  end
end


local function GetZoneInfo(zonename)
	for i=1,4,1 do
		for index,value in pairs(Exp_ZoneNames[i]) do
			if (value == zonename) then
				return i,index;
			end
		end
	end

end

function ExplorerCoords_ClearNotes(whichmap)
	if(whichmap == "world") then
	
		for i=1,30,1 do
			Exp_Target = Exp_Targets[i];
			Exp_Target:Hide();
		end
	elseif(whichmap == "mini") then
		for i=1,30,1 do
			Exp_TargetMini = Exp_TargetsMini[i];
			Exp_TargetMini:Hide();
		end
	end
end

function ExplorerCoords_UpdateMap(whichmap)
	ExplorerCoords_ClearNotes(whichmap);
		
	if(whichmap=="world" and GetCurrentMapZone()<1) then
	  return;
	end  
	  if(whichmap == "world") then
		currentzone = Exp_ZoneNames[GetCurrentMapContinent()][GetCurrentMapZone()];
	  elseif(whichmap == "mini") then
		currentzone = GetRealZoneText();
		
	  end
	  if( ExplorerCoord[currentzone]) then
	    if(whichmap == "world") then
			if(lastmap==currentzone) then
				showmissing = false;
			else
				showmissing = true;
				lastmap = currentzone;
			end;
		end
		
	    catid = ExplorerCoord[currentzone]["catid"];
		--fuckup here still
		if(catid==868) then
			return;
		end
	    for i=1,GetAchievementNumCriteria(catid),1 do
	      criteriaString, criteriaType, completed, quantity, reqQuantity, charName, flags, assetID, quantityString, unknown = GetAchievementCriteriaInfo(catid, i);
	      
		  if(completed) then
	      
	      else
		    if(ExplorerCoord[currentzone][criteriaString]) then
    	      coordx = ExplorerCoord[currentzone][criteriaString]["x"];
	          coordy = ExplorerCoord[currentzone][criteriaString]["y"];
			  
			  if(whichmap == "world") then
				Exp_Target = Exp_Targets[i];
			    Exp_Target.id = criteriaString;
	            Exp_Target:Show();
				Astrolabe:PlaceIconOnWorldMap( WorldMapDetailFrame, Exp_Target, GetCurrentMapContinent(), GetCurrentMapZone(), coordx, coordy );
			  elseif(whichmap == "mini") then
				Exp_TargetMini = Exp_TargetsMini[i];
				Exp_TargetMini.id = criteriaString;
				Exp_TargetMini:Show();
				mini_continent, mini_zone = GetZoneInfo(currentzone);
				Astrolabe:PlaceIconOnMinimap(Exp_TargetMini, mini_continent, mini_zone, coordx, coordy );
			  end
		    else
			  if(showmissing and whichmap == "world") then
				DEFAULT_CHAT_FRAME:AddMessage("Explorer Coords: Missing coords for "..criteriaString);
			  end
			end
	      end
	    end
	  end
	
	
end

function ExplorerCoords_MiniCoord_OnEnter(frame)
  
  local tooltip = GameTooltip;
  tooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT")
  tooltip:ClearLines()
  tooltip:AddLine(frame.id);
  tooltip:Show();

end

function ExplorerCoords_MiniCoord_OnLeave()
  GameTooltip:Hide();
end

function ExplorerCoords_Coord_OnEnter(frame)
  WorldMapPOIFrame.allowBlobTooltip = false;
  local tooltip = WorldMapTooltip;
  tooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT")
  tooltip:ClearLines()
  tooltip:AddLine(frame.id);
  tooltip:Show();

end

function ExplorerCoords_Coord_OnLeave()
  WorldMapPOIFrame.allowBlobTooltip = true;
  WorldMapTooltip:Hide();
end