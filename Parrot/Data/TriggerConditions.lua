local Parrot = Parrot

local mod = Parrot:NewModule("TriggerConditionsData", "AceEvent-3.0")

local L = LibStub("AceLocale-3.0"):GetLocale("Parrot_TriggerConditions_Data")

local newList, del = Parrot.newList, Parrot.del

local debug = Parrot.debug

local onEnableFuncs = {}
function mod:OnEnable()
	for _,v in ipairs(onEnableFuncs) do
		v()
	end
end

local unitChoices = {
	["player"] = PLAYER,
	["focus"] = FOCUS,
	["target"] = TARGET,
	["pet"] = PET,
}

local comparatorChoices = {
	["<"] = "<",
	["<="] = "<=",
	["=="] = "==",
	[">="] = ">=",
	[">"] = ">",
--	["~="] = "~=",
}
local friendlyChoices = {
	[1] = FRIENDLY,
	[0] = HOSTILE,
	[-1] = L["Any"],
}

local comparatorFunc = {
	["<"] = function(arg1, arg2) return arg1 < arg2 end,
	["<="] = function(arg1, arg2) return arg1 <= arg2 end,
	["=="] = function(arg1, arg2) return arg1 == arg2 end,
	[">="] = function(arg1, arg2) return arg1 >= arg2 end,
	[">"] = function(arg1, arg2) return arg1 > arg2 end,
--	["~="] = function(arg1, arg2) return arg1 ~= arg2 end,
}

local function ret(arg)
	return arg
end

local function compare(val1, comparator, val2)
--	debug("compare: ", val1, comparator, val2, " = ", comparatorFunc[comparator](val1, val2))
	return comparatorFunc[comparator](val1, val2)
end

local function parseAmount(arg)
	if not arg then
		return ""
	elseif arg <= 1 then
		return (arg*100) .. "%"
	else
		return tostring(arg)
	end
end

local function saveAmount(arg)
	if arg:match("%d+%%") then
		local percent = tonumber(arg:sub(1,arg:len()-1))
		if percent then
			return percent/100
		end
		return
	else
		return tonumber(arg)
	end
end

local unitHealthStates = {
	player = {},
	target = {},
	pet = {},
	focus = {},
}

Parrot:RegisterPrimaryTriggerCondition {
	name = "Unit health",
	localName = L["Unit health"],
	defaultParam = {
		unit = "player",
		friendly = -1,
		amount = 0.5,
		comparator = "<=",
	},
	param = {
		type = 'group',
		args = {
			unit = {
				name = L["Unit"],
				desc = L["The unit that is affected"],
				type = 'select',
				values = unitChoices,
			},
			friendly = {
				type = 'select',
				name = L["Hostility"],
				desc = L["Whether the unit should be friendly or hostile"],
				values = friendlyChoices,
			},
			amount = {
				type = 'string',
				name = L["Amount"],
				desc = L["Amount of health to compare"],
				parse = parseAmount,
				save = saveAmount,
			},
			comparator = {
				type = 'select',
				name = L["Comparator Type"],
				desc = L["How to compare actual value with parameter"],
				values = comparatorChoices,
			},
		},
	},
	stateful = true,
	getCurrent = function()
		if not UnitExists("target") or not UnitCanAttack("player", "target") or UnitIsDeadOrGhost("target") then
			return nil
		else
		 	return UnitHealth("target")/UnitHealthMax("target")
		end
	end,
	events = {
		UNIT_HEALTH = ret,
		UNIT_MAXHEALTH = ret,
		UNIT_FACTION = ret,
--		PLAYER_TARGET_CHANGED = true,
	},
	check = function(ref, info)
			-- check if ref is complete
			if not (ref.unit and ref.amount and ref.friendly and ref.comparator) then
				return false
			end
			-- only check the unit
			local good = ref.unit == info
			-- check the friendly-flag
			if good and ref.friendly >= 0 then
				good = ref.friendly == 0 and (UnitIsFriend("player", info) == nil) or
					ref.friendly == UnitIsFriend("player", info)
			end
			-- everything fits, check the amount
			if good then
				local amount = ref.amount
				if amount <= 1 then
					amount = UnitHealthMax(info) * ref.amount
				end
				good = compare(UnitHealth(info), ref.comparator, amount)
				-- check if the state has changed
				if good ~= unitHealthStates[ref.unit][ref] then
					unitHealthStates[ref.unit][ref] = good
					return good
				end
			end
		end,
}

local powerTypeChoices = {
	["*"] = L["Any"],
	["MANA"] = MANA,
	["RAGE"] = RAGE,
	["FOCUS"] = FOCUS,
	["ENERGY"] = ENERGY,
	["HAPPINESS"] = HAPPINESS,
--	["RUNES"] = RUNES,
	["RUNIC_POWER"] = RUNIC_POWER,
}

local unitPowerStates = {
	player = {},
	target = {},
	pet = {},
	focus = {},
}

--[[
-- wipe the states for units that can change when they are changed
--]]
table.insert(onEnableFuncs, function()
		mod:RegisterEvent("PLAYER_TARGET_CHANGED", function()
				wipe(unitHealthStates.target)
				wipe(unitPowerStates.target)
			end
		)
	end
)
table.insert(onEnableFuncs, function()
		mod:RegisterEvent("PLAYER_FOCUS_CHANGED", function()
--				debug("wipe focus states")
				wipe(unitHealthStates.focus)
				wipe(unitPowerStates.focus)
			end
		)
	end
)
table.insert(onEnableFuncs, function()
		mod:RegisterEvent("PLAYER_PET", function()
				wipe(unitHealthStates.pet)
				wipe(unitPowerStates.pet)
			end
		)
	end
)

Parrot:RegisterPrimaryTriggerCondition {
	name = "Unit power",
	localName = L["Unit power"],
	defaultParam = {
		unit = "player",
		friendly = -1,
		amount = 0.5,
		comparator = "<=",
		powerType = "MANA",
	},
	param = {
		type = 'group',
		args = {
			unit = {
				name = L["Unit"],
				desc = L["The unit that is affected"],
				type = 'select',
				values = unitChoices,
			},
			friendly = {
				type = 'select',
				name = L["Hostility"],
				desc = L["Whether the unit should be friendly or hostile"],
				values = friendlyChoices,
			},
			amount = {
				type = 'string',
				name = L["Amount"],
				desc = L["Amount of health to compare"],
				parse = parseAmount,
				save = saveAmount,
			},
			comparator = {
				type = 'select',
				name = L["Comparator Type"],
				desc = L["How to compare actual value with parameter"],
				values = comparatorChoices,
			},
			powerType = {
				type = 'select',
				name = L["Power type"],
				desc = L["Type of power"],
				values = powerTypeChoices,
			},
		},
	},
	events = {
		UNIT_MANA = ret,
		UNIT_MAXMANA = ret,
		UNIT_DISPLAYPOWER = ret,
		UNIT_RUNIC_POWER = ret,
		UNIT_ENERGY = ret,
		UNIT_HAPPINESS = ret,
		UNIT_FOCUS = ret,
		UNIT_RAGE = ret,
	},
	check = function(ref, info)
			-- check if ref is complete
			if not (ref.unit and ref.amount and ref.friendly and ref.comparator and ref.powerType) then
				return false
			end
			-- only check the unit
			local good = ref.unit == info

			-- check the powertype
			if good then
				good = ref.powerType == "*" or
					ref.powerType == select(2, UnitPowerType(ref.unit))
			end
			-- check the friendly-flag
			if good and ref.friendly >= 0 then
				good = ref.friendly == 0 and (UnitIsFriend("player", info) == nil) or
					ref.friendly == UnitIsFriend("player", info)
			end
			-- everything fits, check the amount
			if good then
				local amount = ref.amount
				if amount <= 1 then
					amount = UnitPowerMax(info) * ref.amount
				end
				good = compare(UnitPower(info), ref.comparator, amount)
				-- check if the state has changed
				if good ~= unitPowerStates[ref.unit][ref] then
					unitPowerStates[ref.unit][ref] = good
					return good
				end
			end
		end,
}

local missTypeChoices = {
	["ABSORB"] = ABSORB,
	["BLOCK"] = BLOCK,
	["DEFLECT"] = DEFLECT,
	["DODGE"] = DODGE,
	["EVADE"] = EVADE,
	["IMMUNE"] = IMMUNE,
	["MISS"] = MISS,
	["PARRY"] = PARRY,
	["REFLECT"] = REFLECT,
	["RESIST"] = RESIST,
}

Parrot:RegisterPrimaryTriggerCondition {
	name = "Incoming miss",
	localName = L["Incoming miss"],
	combatLogEvents = {
		{
			eventType = "SWING_MISSED",
			triggerData = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
				if dstGUID ~= UnitGUID("player") then
					return nil
				end
				return missType
			end,
		},
	},
	param = {
		type = 'select',
		name = L["Miss type"],
		desc = L["Reason for the miss"],
		values = missTypeChoices,
	}
}

Parrot:RegisterPrimaryTriggerCondition {
	name = "Outgoing miss",
	localName = L["Outgoing miss"],
	combatLogEvents = {
		{
			eventType = "SWING_MISSED",
			triggerData = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
				if srcGUID ~= UnitGUID("player") then
					return nil
				end
				return missType
			end,
		},
	},
	param = {
		type = 'select',
		name = L["Miss type"],
		desc = L["Reason for the miss"],
		values = missTypeChoices,
	},
}

Parrot:RegisterPrimaryTriggerCondition {
	name = "Incoming crit",
	localName = L["Incoming crit"],
	combatLogEvents = {
		{
			eventType = "SPELL_DAMAGE",
			triggerData = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
				if dstGUID ~= UnitGUID("player") or not critical then
					return nil
				end

				return true

			end,
		},
		{
			eventType = "SWING_DAMAGE",
			triggerData = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
				if dstGUID ~= UnitGUID("player") or not critical then
					return nil
				end

				return true

			end,
		},
		{
			eventType = "RANGE_DAMAGE",
			triggerData = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
				if dstGUID ~= UnitGUID("player") or not critical then
					return nil
				end

				return true
			end,

		},
	},
	exclusive = true,
}

Parrot:RegisterPrimaryTriggerCondition {
	name = "Outgoing crit",
	localName = L["Outgoing crit"],
	combatLogEvents = {
		{
			eventType = "SPELL_DAMAGE",
			triggerData = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
				if srcGUID ~= UnitGUID("player") or not critical then
					return nil
				end

				return true

			end,
		},
		{
			eventType = "SWING_DAMAGE",
			triggerData = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
				if srcGUID ~= UnitGUID("player") or not critical then
					return nil
				end

				return true

			end,
		},
		{
			eventType = "RANGE_DAMAGE",
			triggerData = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
				if srcGUID ~= UnitGUID("player") or not critical then
					return nil
				end

				return true

			end,

		},
	},
	exclusive = true,
}

Parrot:RegisterPrimaryTriggerCondition {
	name = "Outgoing cast",
	localName = L["Outgoing cast"],
	combatLogEvents = {
		{
			eventType = "SPELL_DAMAGE",
			triggerData = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
				if srcGUID ~= UnitGUID("player") then
					return nil
				end

				return spellName

			end,

		},
		{
			eventType = "SPELL_PERIODIC_DAMAGE",
			triggerData = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
				if srcGUID ~= UnitGUID("player") then
					return nil
				end

				return spellName

			end,

		},
	},
	param = {
		type = 'string',
		-- usage = L["<Skill name>"],
	},
}

Parrot:RegisterPrimaryTriggerCondition {
	name = "Incoming cast",
	localName = L["Incoming cast"],
	combatLogEvents = {
		{
			eventType = "SPELL_DAMAGE",
			triggerData = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
				if dstGUID ~= UnitGUID("player") then
					return nil
				end

				return spellName

			end,

		},
		{
			eventType = "SPELL_PERIODIC_DAMAGE",
			triggerData = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
				if dstGUID ~= UnitGUID("player") then
					return nil
				end

				return spellName

			end,

		},
	},
	param = {
		type = 'string',
		-- usage = L["<Skill name>"],
	},
}

local function parseSpellDamage(_, srcName, _, _, dstName, _, spellId, spellName, _, amount, _, _, _, _, critical, _, _)
	local data = newList()
	data.dstName = dstName
	data.srcName = srcName
	data.amount = amount
	data.critical = not not critical
	data.spellName = spellName
	data.spellId = spellId
	return data
end

local function parseSwingDamage(_, srcName, _, _, dstName, _, amount, _, _, _, _, _, critical)
	local data = newList()
	data.dstName = dstName
	data.srcName = srcName
	data.amount = amount
	data.critical = not not critical
	return data
end

Parrot:RegisterPrimaryTriggerCondition {
	name = "Incoming damage",
	localName = L["Incoming damage"],
	combatLogEvents = {
		{
			eventType = "SWING_DAMAGE",
			check = function(_, _, _, dstGUID)
					return dstGUID == UnitGUID("player")
				end,
			triggerData = parseSwingDamage,
		},
		{
			eventType = "SPELL_PERIODIC_DAMAGE",
			check = function(_, _, _, dstGUID)
					return dstGUID == UnitGUID("player")
				end,
			triggerData = parseSpellDamage,
		},
		{
			eventType = "SPELL_DAMAGE",
			check = function(_, _, _, dstGUID)
					return dstGUID == UnitGUID("player")
				end,
			triggerData = parseSpellDamage,
		},
		{
			eventType = "RANGE_DAMAGE",
			check = function(_, _, _, dstGUID)
					return dstGUID == UnitGUID("player")
				end,
			triggerData = parseSpellDamage,
		},
	},
	defaultParam = {
		unit = "target",
		comparator = ">",
		amount = 0,
	},
	param = {
		type = 'group',
		args = {
			unit = {
				name = L["Unit"],
				desc = L["The unit that attacked you"],
				type = 'input',
				usage = "\"player\" or \"target\" or \"<unit name>\"", -- TODO L[]
			},
			amount = {
				name = L["Amount"],
				desc = L["Amount of damage to compare with"],
				type = 'input',
				save = function(value) return tonumber(value) end,
				parse = function(value) return tostring(value or "") end,
			},
			comparator = {
				type = 'select',
				name = L["Comparator Type"],
				desc = L["How to compare actual value with parameter"],
				values = comparatorChoices,
			},
		},
	},
	check = function(ref, info)
			if not ref.unit then
				return false
			end
			local good = ref.unit == info.srcName or info.srcName == UnitName(ref.unit)
			if good and ref.amount then
				if not ref.comparator then
					return false
				else
					good = compare(info.amount, ref.comparator, ref.amount)
				end
			end
			return good
		end,
}

Parrot:RegisterPrimaryTriggerCondition {
	name = "Outgoing damage",
	localName = L["Outgoing damage"],
	combatLogEvents = {
		{
			eventType = "SWING_DAMAGE",
			check = function(_, _, _, dstGUID)
					return dstGUID == UnitGUID("player")
				end,
			triggerData = parseSwingDamage,
		},
		{
			eventType = "SPELL_PERIODIC_DAMAGE",
			check = function(_, _, _, dstGUID)
					return dstGUID == UnitGUID("player")
				end,
			triggerData = parseSpellDamage,
		},
		{
			eventType = "SPELL_DAMAGE",
			check = function(_, _, _, dstGUID)
					return dstGUID == UnitGUID("player")
				end,
			triggerData = parseSpellDamage,
		},
		{
			eventType = "RANGE_DAMAGE",
			check = function(_, _, _, dstGUID)
					return dstGUID == UnitGUID("player")
				end,
			triggerData = parseSpellDamage,
		},
	},
	defaultParam = {
		unit = "target",
		comparator = ">",
		amount = 0,
	},
	param = {
		type = 'group',
		args = {
			unit = {
				name = L["Unit"],
				desc = L["The unit that you attacked"],
				type = 'input',
				usage = "\"player\" or \"target\" or \"<unit name>\"", -- TODO L[]
			},
			amount = {
				name = L["Amount"],
				desc = L["Amount of damage to compare with"],
				type = 'input',
				save = function(value) return tonumber(value) end,
				parse = function(value) return tostring(value or "") end,
			},
			comparator = {
				type = 'select',
				name = L["Comparator Type"],
				desc = L["How to compare actual value with parameter"],
				values = comparatorChoices,
			},
		},
	},
	check = function(ref, info)
			if not ref.unit then
				return false
			end
			local good = ref.unit == info.dstName or info.dstName == UnitName(ref.unit)
			if good and ref.amount then
				if not ref.comparator then
					return false
				else
					good = compare(info.amount, ref.comparator, ref.amount)
				end
			end
			return good
		end,
}

local function manastep()
	return math.min(50, UnitManaMax("player")/10)
end

Parrot:RegisterSecondaryTriggerCondition {
	name = "Unit power",
	localName = L["Unit power"],
	defaultParam = {
		unit = "player",
		comparator = "<=",
		amount = 0.4,
		friendly = -1,
		powerType = "MANA",
	},
	param = {
		type = 'group',
		args = {
			unit = {
				name = L["Unit"],
				desc = L["The unit that is affected"],
				type = 'select',
				values = unitChoices,
			},
			friendly = {
				type = 'select',
				name = L["Hostility"],
				desc = L["Whether the unit should be friendly or hostile"],
				values = friendlyChoices,
			},
			amount = {
				type = 'string',
				name = L["Amount"],
				desc = L["Amount of power to compare"],
				save = saveAmount,
				parse = parseAmount,
			},
			powerType = {
				type = 'select',
				name = L["Power type"],
				desc = L["Type of power"],
				values = powerTypeChoices,
			},
			comparator = {
				type = 'select',
				name = L["Comparator Type"],
				desc = L["How to compare actual value with parameter"],
				values = comparatorChoices,
			},
		},
	},
	check = function(ref)
			-- check if ref is complete
			if not (ref.unit and ref.amount and ref.friendly and ref.comparator
								and ref.powerType) then
				return false
			end
			local good = ref.powerType == "*" or
					ref.powerType == select(2, UnitPowerType(ref.unit))
			-- check the friendly-flag
			if good and ref.friendly >= 0 then
				good = ref.friendly == 0 and (UnitIsFriend("player", ref.unit) == nil) or
					ref.friendly == UnitIsFriend("player", ref.unit)
			end
			-- everything fits, check the amount
			if good then
				local amount = ref.amount
				if amount <= 1 then
					amount = UnitPowerMax(ref.unit) * ref.amount
				end
				return compare(UnitPower(ref.unit), ref.comparator, amount)
			end
		end,
}

Parrot:RegisterSecondaryTriggerCondition {
	name = "Unit health",
	localName = L["Unit health"],
	defaultParam = {
		unit = "player",
		comparator = "<=",
		amount = 0.5,
		friendly = -1,
	},
	param = {
		type = 'group',
		args = {
			unit = {
				name = L["Unit"],
				desc = L["The unit that is affected"],
				type = 'select',
				values = unitChoices,
			},
			friendly = {
				type = 'select',
				name = L["Hostility"],
				desc = L["Whether the unit should be friendly or hostile"],
				values = friendlyChoices,
			},
			amount = {
				type = 'string',
				name = L["Amount"],
				desc = L["Amount of health to compare"],
				save = saveAmount,
				parse = parseAmount,
			},
			comparator = {
				type = 'select',
				name = L["Comparator Type"],
				desc = L["How to compare actual value with parameter"],
				values = comparatorChoices,
			},
		},
	},
	check = function(ref)
			-- check if ref is complete
			if not (ref.unit and ref.amount and ref.friendly and ref.comparator) then
				return false
			end
			local good = true
			-- check the friendly-flag
			if ref.friendly >= 0 then
				good = ref.friendly == 0 and (UnitIsFriend("player", ref.unit) == nil) or
					ref.friendly == UnitIsFriend("player", ref.unit)
			end
			-- everything fits, check the amount
			if good then
				local amount = ref.amount
				if amount <= 1 then
					debug("checking percent amount")
					amount = UnitHealthMax(ref.unit) * ref.amount
				end
				return compare(UnitHealth(ref.unit), ref.comparator, amount)
			end
		end,
}


Parrot:RegisterSecondaryTriggerCondition {
	name = "Warrior stance",
	localName = L["Warrior stance"],
	notLocalName = L["Not in warrior stance"],
	param = {
		type = 'select',
		values = {
			["Battle Stance"] = GetSpellInfo(2457),
			["Defensive Stance"] = GetSpellInfo(71),
			["Berserker Stance"] = GetSpellInfo(2458),
		}
	},
	check = function(param)
		if select(2,UnitClass("player")) ~= "WARRIOR" then
			return true
		end
		local form = GetShapeshiftForm(true)
		if form == 1 then
			return param == "Battle Stance"
		elseif form == 2 then
			return param == "Defensive Stance"
		elseif form == 3 then
			return param == "Berserker Stance"
		end
		return false
	end,
}

Parrot:RegisterSecondaryTriggerCondition {
	name = "Druid Form",
	localName = L["Druid Form"],
	notLocalName = L["Not in Druid Form"],
	param = {
		type = 'select',
		values = {
			["Bear Form"] = GetSpellInfo(5487),
			["Aquatic Form"] = GetSpellInfo(1066),
			["Cat Form"] = GetSpellInfo(768),
			["Travel Form"] = GetSpellInfo(783),
			["Flight Form"] = GetSpellInfo(33943),
			["Moonkin Form"] = GetSpellInfo(24858),
			["Tree of Life"] = GetSpellInfo(33891),
		}
	},
	check = function(param)
		if select(2,UnitClass("player")) ~= "DRUID" then
			return true
		end

		local form = GetShapeshiftForm(true)
		if form == 1 then
			return param == "Bear Form"
		elseif form == 2 then
			return param == "Aquatic Form"
		elseif form == 3 then
			return param == "Cat Form"
		elseif form == 4 then
			return param == "Travel Form"
		elseif form == 5 then
			local real5 = GetShapeshiftFormInfo(5)
			if real5 == GetSpellInfo(24858) then
				return param == "Moonkin Form"
			elseif real5 == GetSpellInfo(33891) then
				return param == "Tree of Life"
			elseif real5 == GetSpellInfo(40120) or real5 == GetSpellInfo(33943) then
				return param == "Flight Form"
			end
		elseif form == 6 then
			return param == "Flight Form"
		end
		return false
	end,
}

Parrot:RegisterSecondaryTriggerCondition {
	name = "Deathknight presence",
	localName = L["Deathknight presence"],
	notLocalName = L["Not Deathknight presence"],
	param = {
		type = 'select',
		values = {
			["Blood Presence"] = GetSpellInfo(50475),
			["Frost Presence"] = GetSpellInfo(61261),
			["Unholy Presence"] = GetSpellInfo(55222),
		}
	},
	check = function(param)
		if select(2,UnitClass("player")) ~= "DEATHKNIGHT" then
			return true
		end
		local form = GetShapeshiftForm(false)
		if form == 1 then
			return param == "Blood Presence"
		elseif form == 2 then
			return param == "Frost Presence"
		elseif form == 3 then
			return param == "Unholy Presence"
		end
		return false
	end,
}

Parrot:RegisterSecondaryTriggerCondition {
  name = "Grouped",
  localName = L["In a Group or Raid"],
  check = function()
      return GetNumPartyMembers() > 0 or UnitInRaid("player")
  end,
 	exclusive = true,
}

Parrot:RegisterSecondaryTriggerCondition {
    name = "Mounted",
    localName = L["Mounted"],
    notLocalName = L["Not mounted"],
    check = function()
        return IsMounted()
    end,
    exclusive = true,
}

Parrot:RegisterSecondaryTriggerCondition {
    name = "InVehicle",
    localName = L["In vehicle"],
    notLocalName = L["Not in vehicle"],
    check = function()
        return UnitInVehicle("player")
    end,
   	exclusive = true
}

Parrot:RegisterPrimaryTriggerCondition {
	name = "Successful spell cast",
	localName = L["Successful spell cast"],
	combatLogEvents = {
		{
			eventType = "SPELL_CAST_SUCCESS",
			triggerData = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName )
				return ("%s,%s,%s"):format(srcName or "", dstName or "", spellName or "")
			end,
		},
	},
	-- TODO
	param = {
		type = 'string',
		usage = L["<Sourcename>,<Destinationname>,<Spellname>"],
	},
}

Parrot:RegisterSecondaryTriggerCondition {
	name = "Target is player",
	localName = L["Target is player"],
	notLocalName = L["Target is NPC"],
	check = function()
		if UnitIsDeadOrGhost("target") then
			return false
		end
		return UnitIsPlayer("target")
	end,
	exclusive = true
}


local luacache = {}

Parrot:RegisterSecondaryTriggerCondition {
	name = "Lua function",
	localName = L["Lua function"],
	defaultParam = "return true",
	param = {
		type = 'string',
		multiline = true,
		width = 'full',
	},
	check = function(param)
		local func = luacache[param]
		if not func then
			-- It's not there yet. build it+

			if type(param) ~= 'string' then
				debug(param, " is not a string")
				return false
			end
			local lua_string = 'return function() '..param..' end'
			local create_func, err = loadstring(lua_string)
			if create_func then
				func = create_func()
				-- and put it in the cache
				luacache[param] = func
			else
				geterrorhandler()(err)
				return false
			end
		end
		return func()
	end,
}

Parrot:RegisterSecondaryTriggerCondition {
	name = "Active talents",
	localName = L["Active talents"],
	defaultParam = 1,
	exclusive = true,
	param = {
		type = 'select',
		values = {
			[1] = L["Primary"],
			[2] = L["Secondary"],
		},
	},
	check = function(param)
			return GetActiveTalentGroup() == param
		end,
}
