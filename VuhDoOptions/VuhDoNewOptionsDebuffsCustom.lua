local VUHDO_COMBO_MODEL = nil;



--
local tStoredName;
local tIndex;
local tDebuffsSorted = { };
function VUHDO_initCustomDebuffComboModel()
  table.sort(VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED"],
		function(aDebuff, anotherDebuff)
			return aDebuff < anotherDebuff;
		end
	);

	VUHDO_COMBO_MODEL = { };
	for tIndex, tStoredName in ipairs(VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED"]) do
		VUHDO_COMBO_MODEL[tIndex] = { tStoredName, tStoredName };
	end
end



--
function VUHDO_setupCustomDebuffsComboModel(aComboBox)
	if (VUHDO_COMBO_MODEL == nil) then
		VUHDO_initCustomDebuffComboModel();
		VUHDO_notifyCustomDebuffSelect(aComboBox, VUHDO_CONFIG.CUSTOM_DEBUFF.SELECTED);
	end

	VUHDO_setComboModel(aComboBox, "VUHDO_CONFIG.CUSTOM_DEBUFF.SELECTED", VUHDO_COMBO_MODEL);
	VUHDO_lnfComboBoxInitFromModel(aComboBox);
end



--
function VUHDO_notifyCustomDebuffSelect(aComboBox, aValue)
	if (VuhDoNewOptionsDebuffsCustomStorePanelEditBox ~= nil and aValue ~= nil) then
		VuhDoNewOptionsDebuffsCustomStorePanelEditBox:SetText(aValue);
	else
		VuhDoNewOptionsDebuffsCustomStorePanelEditBox:SetText("");
	end
end


VUHDO_ICON_MODEL = nil;
VUHDO_COLOR_MODEL = nil;
VUHDO_ANIMATE_MODEL = nil;
VUHDO_TIMER_MODEL = nil;
VUHDO_STACKS_MODEL = nil;
VUHDO_COLOR_SWATCH_MODEL = nil;
VUHDO_SOUND_MODEL = nil;
--VUHDO_TOGGLE_NAME_MODEL = nil;



--
local tIdx, tValue;
local function VUHDO_getTableIndex(aTable, aValue)
	for tIdx, tValue in pairs(aTable) do
		if (tValue == aValue) then
			return tIdx;
		end
	end

	return nil;
end



--
local tValue;
local tIndex;
local tPanelName;
local tCheckButton;
local tComboBox;
local tColorSwatch;

function VUHDO_customDebuffUpdateEditBox(anEditBox)
	tValue = anEditBox:GetText();
	tIndex = VUHDO_getTableIndex(VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED"], tValue);

	if (tIndex ~= nil) then
		anEditBox:SetTextColor(1, 1, 1, 1);

		tPanelName = anEditBox:GetParent():GetName();

		tCheckButton = VUHDO_GLOBAL[tPanelName .. "IconCheckButton"];
		VUHDO_lnfSetModel(tCheckButton, "VUHDO_CONFIG.CUSTOM_DEBUFF.STORED_SETTINGS." .. tValue .. ".isIcon");
		VUHDO_lnfCheckButtonInitFromModel(tCheckButton);

		tCheckButton = VUHDO_GLOBAL[tPanelName .. "ColorCheckButton"];
		VUHDO_lnfSetModel(tCheckButton, "VUHDO_CONFIG.CUSTOM_DEBUFF.STORED_SETTINGS." .. tValue .. ".isColor");
		VUHDO_lnfCheckButtonInitFromModel(tCheckButton);

		tCheckButton = VUHDO_GLOBAL[tPanelName .. "AnimateCheckButton"];
		VUHDO_lnfSetModel(tCheckButton, "VUHDO_CONFIG.CUSTOM_DEBUFF.STORED_SETTINGS." .. tValue .. ".animate");
		VUHDO_lnfCheckButtonInitFromModel(tCheckButton);

		tCheckButton = VUHDO_GLOBAL[tPanelName .. "TimerCheckButton"];
		VUHDO_lnfSetModel(tCheckButton, "VUHDO_CONFIG.CUSTOM_DEBUFF.STORED_SETTINGS." .. tValue .. ".timer");
		VUHDO_lnfCheckButtonInitFromModel(tCheckButton);

		tCheckButton = VUHDO_GLOBAL[tPanelName .. "StacksCheckButton"];
		VUHDO_lnfSetModel(tCheckButton, "VUHDO_CONFIG.CUSTOM_DEBUFF.STORED_SETTINGS." .. tValue .. ".isStacks");
		VUHDO_lnfCheckButtonInitFromModel(tCheckButton);

		tComboBox = VUHDO_GLOBAL[tPanelName .. "SoundCombo"];
		VUHDO_setComboModel(tComboBox, "VUHDO_CONFIG.CUSTOM_DEBUFF.STORED_SETTINGS." .. tValue .. ".SOUND", VUHDO_SOUNDS);
		VUHDO_lnfComboBoxInitFromModel(tComboBox);

		if (VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][tValue].isColor) then
			if (VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][tValue].color == nil) then
					VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][tValue].color
						= VUHDO_deepCopyTable(VUHDO_PANEL_SETUP.BAR_COLORS["DEBUFF" .. VUHDO_DEBUFF_TYPE_CUSTOM]);
			end
		else
			VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][tValue].color = nil;
		end

		tColorSwatch = VUHDO_GLOBAL[tPanelName .. "ColorTexture"];
		VUHDO_lnfSetModel(tColorSwatch, "VUHDO_CONFIG.CUSTOM_DEBUFF.STORED_SETTINGS." .. tValue .. ".color");
		VUHDO_lnfInitColorSwatch(tColorSwatch, VUHDO_I18N_COLOR, VUHDO_I18N_COLOR);
		VUHDO_lnfColorSwatchInitFromModel(tColorSwatch);
	else
		anEditBox:SetTextColor(0.8, 0.8, 1, 1);

		tPanelName = anEditBox:GetParent():GetName();

		VUHDO_ICON_MODEL = VUHDO_CONFIG.CUSTOM_DEBUFF.isIcon;
		VUHDO_COLOR_MODEL = VUHDO_CONFIG.CUSTOM_DEBUFF.isColor;
		VUHDO_ANIMATE_MODEL = VUHDO_CONFIG.CUSTOM_DEBUFF.animate;
		VUHDO_TIMER_MODEL = VUHDO_CONFIG.CUSTOM_DEBUFF.timer;
		VUHDO_STACKS_MODEL = VUHDO_CONFIG.CUSTOM_DEBUFF.isStacks;
--		VUHDO_TOGGLE_NAME_MODEL = VUHDO_CONFIG.CUSTOM_DEBUFF.toggleName;
    VUHDO_COLOR_SWATCH_MODEL = VUHDO_deepCopyTable(VUHDO_PANEL_SETUP.BAR_COLORS["DEBUFF" .. VUHDO_DEBUFF_TYPE_CUSTOM]);
    VUHDO_SOUND_MODEL = VUHDO_CONFIG.CUSTOM_DEBUFF.SOUND;

		tCheckButton = VUHDO_GLOBAL[tPanelName .. "IconCheckButton"];
		VUHDO_lnfSetModel(tCheckButton, "VUHDO_ICON_MODEL");
		VUHDO_lnfCheckButtonInitFromModel(tCheckButton);

		tCheckButton = VUHDO_GLOBAL[tPanelName .. "ColorCheckButton"];
		VUHDO_lnfSetModel(tCheckButton, "VUHDO_COLOR_MODEL");
		VUHDO_lnfCheckButtonInitFromModel(tCheckButton);

		tCheckButton = VUHDO_GLOBAL[tPanelName .. "AnimateCheckButton"];
		VUHDO_lnfSetModel(tCheckButton, "VUHDO_ANIMATE_MODEL");
		VUHDO_lnfCheckButtonInitFromModel(tCheckButton);

		tCheckButton = VUHDO_GLOBAL[tPanelName .. "TimerCheckButton"];
		VUHDO_lnfSetModel(tCheckButton, "VUHDO_TIMER_MODEL");
		VUHDO_lnfCheckButtonInitFromModel(tCheckButton);

		tCheckButton = VUHDO_GLOBAL[tPanelName .. "StacksCheckButton"];
		VUHDO_lnfSetModel(tCheckButton, "VUHDO_STACKS_MODEL");
		VUHDO_lnfCheckButtonInitFromModel(tCheckButton);

		tComboBox = VUHDO_GLOBAL[tPanelName .. "SoundCombo"];
		VUHDO_setComboModel(tComboBox, "VUHDO_SOUND_MODEL", VUHDO_SOUNDS);
		VUHDO_lnfComboBoxInitFromModel(tComboBox);

		tColorSwatch = VUHDO_GLOBAL[tPanelName .. "ColorTexture"];
		VUHDO_lnfSetModel(tColorSwatch, "VUHDO_COLOR_SWATCH_MODEL");
		VUHDO_lnfInitColorSwatch(tColorSwatch, VUHDO_I18N_COLOR, VUHDO_I18N_COLOR);
		VUHDO_lnfColorSwatchInitFromModel(tColorSwatch);
	end
end



--
local tOldValue = nil;
function VUHDO_notifySoundSelect(aComboBox, aValue)
	if (aValue ~= nil and tOldValue ~= aValue) then
		PlaySoundFile(aValue);
		tOldValue = aValue;
	end
end



--
function VUHDO_custonDebuffisColorClicked()
	VUHDO_customDebuffUpdateEditBox(VuhDoNewOptionsDebuffsCustomStorePanelEditBox);
end



--
local tEditBox;
local tValue;
local tIndex;
local tCheckButton;
local tPanelName;
function VUHDO_saveCustomDebuffOnClick(aButton)
	tEditBox = VUHDO_GLOBAL[aButton:GetParent():GetName() .. "EditBox"];
	tValue = strtrim(tEditBox:GetText());
	tIndex = VUHDO_getTableIndex(VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED"], tValue);

	if (tIndex == nil and strlen(tValue) > 0) then
		tinsert(VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED"], tValue);
		VuhDoNewOptionsDebuffsCustomStorePanelEditBox:SetText(tValue);
		VuhDoNewOptionsDebuffsCustomStorePanelEditBox:SetTextColor(1, 1, 1);
	else
		VUHDO_Msg("(de)buff " .. tValue .. " updated.");
	end

	tPanelName = aButton:GetParent():GetName();

	VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][tValue] = { };

	tCheckButton = VUHDO_GLOBAL[tPanelName .. "IconCheckButton"];
	VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][tValue].isIcon = VUHDO_forceBooleanValue(tCheckButton:GetChecked());

	tCheckButton = VUHDO_GLOBAL[tPanelName .. "ColorCheckButton"];
	VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][tValue].isColor = VUHDO_forceBooleanValue(tCheckButton:GetChecked());

	tCheckButton = VUHDO_GLOBAL[tPanelName .. "AnimateCheckButton"];
	VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][tValue].animate = VUHDO_forceBooleanValue(tCheckButton:GetChecked());

	tCheckButton = VUHDO_GLOBAL[tPanelName .. "TimerCheckButton"];
	VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][tValue].timer = VUHDO_forceBooleanValue(tCheckButton:GetChecked());

	tCheckButton = VUHDO_GLOBAL[tPanelName .. "StacksCheckButton"];
	VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][tValue].isStacks = VUHDO_forceBooleanValue(tCheckButton:GetChecked());

	tComboBox = VUHDO_GLOBAL[tPanelName .. "SoundCombo"];
	VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][tValue].SOUND = VUHDO_lnfGetValueFromModel(tComboBox);
	VUHDO_lnfComboBoxInitFromModel(tComboBox);

	tColorSwatch = VUHDO_GLOBAL[tPanelName .. "ColorTexture"];

	if (VUHDO_COLOR_SWATCH_MODEL == nil) then
		VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][tValue].color
		  = VUHDO_deepCopyTable(VUHDO_PANEL_SETUP.BAR_COLORS["DEBUFF" .. VUHDO_DEBUFF_TYPE_CUSTOM]);
	else
		VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][tValue].color
			= VUHDO_deepCopyTable(VUHDO_COLOR_SWATCH_MODEL);
	end

	VUHDO_CONFIG["CUSTOM_DEBUFF"]["SELECTED"] = tValue;
	VUHDO_initCustomDebuffComboModel();
	VUHDO_customDebuffUpdateEditBox(VuhDoNewOptionsDebuffsCustomStorePanelEditBox);
	VuhDoNewOptionsDebuffsCustom:Hide();
	VuhDoNewOptionsDebuffsCustom:Show();
end



--
local tEditBox;
local tValue;
local tIndex;
function VUHDO_deleteCustomDebuffOnClick(aButton)
	tEditBox = VUHDO_GLOBAL[aButton:GetParent():GetName() .. "EditBox"];
	tValue = strtrim(tEditBox:GetText());
	tIndex = VUHDO_getTableIndex(VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED"], tValue);

	if (tIndex ~= nil and strlen(tValue) > 0) then
		tremove(VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED"], tIndex);
		VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][tValue] = nil;
		VUHDO_Msg("(de)buff " .. tValue .. " removed.", 1, 0.4, 0.4);
	else
		VUHDO_Msg("(de)buff " .. tValue .. " doesn't exist.", 1, 0.4, 0.4);
	end

	VUHDO_initCustomDebuffComboModel();
	VUHDO_customDebuffUpdateEditBox(VuhDoNewOptionsDebuffsCustomStorePanelEditBox);
	VuhDoNewOptionsDebuffsCustom:Hide();
	VuhDoNewOptionsDebuffsCustom:Show();
	VuhDoNewOptionsDebuffsCustomStorePanelEditBox:SetText("");
end



--
local tName, tSettings;
function VUHDO_applyToAllCustomDebuffOnClick()
	for tName, tSettings in pairs(VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"]) do
		tSettings["isIcon"] = VUHDO_CONFIG.CUSTOM_DEBUFF.isIcon;
		tSettings["isColor"] = VUHDO_CONFIG.CUSTOM_DEBUFF.isColor;
		tSettings["SOUND"] = VUHDO_CONFIG.CUSTOM_DEBUFF.SOUND;
		tSettings["animate"] = VUHDO_CONFIG.CUSTOM_DEBUFF.animate;
		tSettings["timer"] = VUHDO_CONFIG.CUSTOM_DEBUFF.timer;
		tSettings["isStacks"] = VUHDO_CONFIG.CUSTOM_DEBUFF.isStacks;
		tSettings["toggleName"] = VUHDO_CONFIG.CUSTOM_DEBUFF.toggleName;
		if (tSettings["isColor"]) then
			tSettings["color"] = VUHDO_deepCopyTable(VUHDO_PANEL_SETUP.BAR_COLORS["DEBUFF" .. VUHDO_DEBUFF_TYPE_CUSTOM]);
		else
			tSettings["color"] = nil;
		end
	end

	VuhDoNewOptionsDebuffsCustomStorePanel:Hide();
	VuhDoNewOptionsDebuffsCustomStorePanel:Show();
end