
if (GetLocale() ~= "esES") then
	return;
end

-- � = \195\161
-- � = \195\169
-- � = \195\173
-- � = \195\179
-- � = \195\186
-- � = \195\177
-- � = \195\170
-- � = \195\175
-- � = \195\180
-- � = \195\185
-- � = \197\146
-- � = \197\147

-- @EXACT = true: Translation has to be the exact(!) match in the clients language,
--                beacause it carries technical semantics
-- @EXACT = false: Translation can be done freely, because text is only descriptive


-- Class Names
-- @EXACT = false
VUHDO_I18N_WARRIORS="Guerreros"
VUHDO_I18N_ROGUES = "P�caros";
VUHDO_I18N_HUNTERS = "Cazadores";
VUHDO_I18N_PALADINS = "Paladines";
VUHDO_I18N_MAGES = "Magos";
VUHDO_I18N_WARLOCKS = "Brujos";
VUHDO_I18N_SHAMANS = "Chamanes";
VUHDO_I18N_DRUIDS = "Druidas";
VUHDO_I18N_PRIESTS = "Sacerdotes";
VUHDO_I18N_DEATH_KNIGHT = "Caballeros de la Muerte";


-- Group Model Names
-- @EXACT = false
VUHDO_I18N_GROUP = "Grupo";
VUHDO_I18N_OWN_GROUP = "Mi Grupo";


-- Special Model Names
-- @EXACT = false
VUHDO_I18N_PETS = "Mascotas";
VUHDO_I18N_MAINTANKS = "Tanques principales";
VUHDO_I18N_PRIVATE_TANKS = "Mis objetivos";



-- General Labels
-- @EXACT = false
VUHDO_I18N_OKAY = "Aceptar";
VUHDO_I18N_CLASS = "Clase";
VUHDO_I18N_UNDEFINED = "<n/a>";
VUHDO_I18N_PLAYER = "Jugador";



-- VuhDoTooltip.lua
-- @EXACT = false
VUHDO_I18N_TT_POSITION = "|cffffb233Position:|r";
VUHDO_I18N_TT_GHOST = "<GHOST>";
VUHDO_I18N_TT_DEAD = "<DEAD>";
VUHDO_I18N_TT_AFK = "<AFK>";
VUHDO_I18N_TT_DND = "<DND>";
VUHDO_I18N_TT_LIFE = "|cffffb233Vida:|r ";
VUHDO_I18N_TT_MANA = "|cffffb233Mana:|r ";
VUHDO_I18N_TT_LEVEL = "Nivel ";


-- VuhDoPanel.lua
-- @EXACT = false
VUHDO_I18N_CHOOSE = "Seleccionar";
VUHDO_I18N_DRAG = "Arrastrar";
VUHDO_I18N_REMOVE = "Suprimir";
VUHDO_I18N_ME = "mi!";
VUHDO_I18N_TYPE = "Tipo";
VUHDO_I18N_VALUE = "Valor";
VUHDO_I18N_SPECIAL = "Especial";
VUHDO_I18N_BUFF_ALL = "todos";
VUHDO_I18N_SHOW_BUFF_WATCH = "Muestra buscador de buffs";


-- @EXACT = true
--
VUHDO_I18N_RANK = "Rango";

-- Chat messages
-- @EXACT = false
VUHDO_I18N_COMMAND_LIST = "\n|cffffe566 - [ Commandes VuhDo] -|r";
VUHDO_I18N_COMMAND_LIST = VUHDO_I18N_COMMAND_LIST .. "�|cffffe566opt|r[ions] - Opciones de VuhDo";
VUHDO_I18N_COMMAND_LIST = VUHDO_I18N_COMMAND_LIST .. "�|cffffe566res|r[et] - Resetear la posicion del panel";
VUHDO_I18N_COMMAND_LIST = VUHDO_I18N_COMMAND_LIST .. "�|cffffe566lock|r - Cambiar Panel Bloqueado";
VUHDO_I18N_COMMAND_LIST = VUHDO_I18N_COMMAND_LIST .. "�|cffffe566mm, map, minimap|r - Activar Icono de minimapa";
VUHDO_I18N_COMMAND_LIST = VUHDO_I18N_COMMAND_LIST .. "�|cffffe566show, hide, toggle|r - Girar paneles";
VUHDO_I18N_COMMAND_LIST = VUHDO_I18N_COMMAND_LIST .. "�|cffffe566load|r - [Profile],[Key Layout]";
VUHDO_I18N_COMMAND_LIST = VUHDO_I18N_COMMAND_LIST .. "�[broad]|cffffe566cast, mt|r[s] - Configurar tanques principales";
VUHDO_I18N_COMMAND_LIST = VUHDO_I18N_COMMAND_LIST .. "�|cffffe566role|r - Restablecer rol de jugadores";
VUHDO_I18N_COMMAND_LIST = VUHDO_I18N_COMMAND_LIST .. "�|cffffe566aegis x|r - Set Divine Aegis detection sensivity";
VUHDO_I18N_COMMAND_LIST = VUHDO_I18N_COMMAND_LIST .. "�|cffffe566help,?|r - Lista de comandos\n";

VUHDO_I18N_BAD_COMMAND = "Comando invalido! Teclea '/vuhdo help' or '/vd ?' para ver la lista de comandos.";
VUHDO_I18N_CHAT_SHOWN = "|cffffe566visible|r.";
VUHDO_I18N_CHAT_HIDDEN = "|cffffe566cach\195\169|r.";
VUHDO_I18N_MM_ICON = "El icono del minimapa esta activo ";
VUHDO_I18N_MTS_BROADCASTED = "Tanques principales incorporados a la raid";
VUHDO_I18N_PANELS_SHOWN = "Paneles de healers estan ahora |cffffe566shown|r.";
VUHDO_I18N_PANELS_HIDDEN = "Paneles de healers estan ahora |cffffe566hidden|r.";
VUHDO_I18N_LOCK_PANELS_PRE = "La posicion de los paneles esta bloqueada ";
VUHDO_I18N_LOCK_PANELS_LOCKED = "|cffffe566v\195\169rouill\195\169|r.";
VUHDO_I18N_LOCK_PANELS_UNLOCKED = "|cffffe566d\195\169v\195\169rouill\195\169|r.";
VUHDO_I18N_PANELS_RESET = "La posicion de los paneles ha sido reseteado.";


-- Config Pop-Up
-- @EXACT = false
VUHDO_I18N_ROLE = "Roll";
VUHDO_I18N_PRIVATE_TANK = "Tanques personalizados";
VUHDO_I18N_SET_BUFF = "Definir los buffos";


-- Minimap
-- @EXACT = false
VUHDO_I18N_VUHDO_OPTIONS = "Opciones de VuhDo";
VUHDO_I18N_PANEL_SETUP = "Opciones";
VUHDO_I18N_MM_TOOLTIP = "Izquierda: Configuracion del panel\nDerecha: Menu";
VUHDO_I18N_TOGGLES = "Posicion";
VUHDO_I18N_LOCK_PANELS = "Bloquear Paneles";
VUHDO_I18N_SHOW_PANELS = "Mostrar Paneles";
VUHDO_I18N_MM_BUTTON = "Boton del Minimapa";
VUHDO_I18N_CLOSE = "Cerrar";
VUHDO_I18N_BROADCAST_MTS = "Sincronizar MTS";


-- Buff categories
-- @EXACT = false
-- Priest
VUHDO_I18N_BUFFC_FORTITUDE = "01Entereza";
VUHDO_I18N_BUFFC_SPIRIT = "02Espiritu";
VUHDO_I18N_BUFFC_SHADOW_PROTECTION = "03Proteccion contra las sombras";

-- Shaman
VUHDO_I18N_BUFFC_FIRE_TOTEM = "01Totem de fuego";
VUHDO_I18N_BUFFC_AIR_TOTEM = "02Totem de aire";
VUHDO_I18N_BUFFC_EARTH_TOTEM = "03Totem de tierra";
VUHDO_I18N_BUFFC_WATER_TOTEM = "04Totem de agua";
VUHDO_I18N_BUFFC_WEAPON_ENCHANT = "08Armas encantadas";
VUHDO_I18N_BUFFC_WEAPON_ENCHANT_2 = "13Armas encantadas 2";
VUHDO_I18N_BUFFC_SHIELDS = "09Escudos";

-- Paladin
VUHDO_I18N_BUFFC_BLESSING = "01Bendicion";
VUHDO_I18N_BUFFC_AURA = "02Aura";
VUHDO_I18N_BUFFC_SEAL = "03Sello";

-- Druids

-- Warlock
VUHDO_I18N_BUFFC_SKIN = "01Piel de demonio";

-- Mage
VUHDO_I18N_BUFFC_ARMOR_MAGE = "03Armadura";

-- Death Knight
VUHDO_SPELL_ID_BUFFC_PRESENCE    = "03Presencia";

-- Warrior
VUHDO_I18N_BUFFC_SHOUT = "01Grito";

-- Hunter
VUHDO_I18N_BUFFC_ASPECT = "02Aspecto";


-- Key Binding Headers/Names
-- @EXACT = false
BINDING_HEADER_VUHDO_TITLE = "VuhDo - Raid Frames";
BINDING_NAME_VUHDO_KEY_ASSIGN_1 = "Mouse over - Sort 1";
BINDING_NAME_VUHDO_KEY_ASSIGN_2 = "Mouse over - Sort 2";
BINDING_NAME_VUHDO_KEY_ASSIGN_3 = "Mouse over - Sort 3";
BINDING_NAME_VUHDO_KEY_ASSIGN_4 = "Mouse over - Sort 4";
BINDING_NAME_VUHDO_KEY_ASSIGN_5 = "Mouse over - Sort 5";
BINDING_NAME_VUHDO_KEY_ASSIGN_6 = "Mouse over - Sort 6";
BINDING_NAME_VUHDO_KEY_ASSIGN_7 = "Mouse over - Sort 7";
BINDING_NAME_VUHDO_KEY_ASSIGN_8 = "Mouse over - Sort 8";
BINDING_NAME_VUHDO_KEY_ASSIGN_9 = "Mouse over - Sort 9";
BINDING_NAME_VUHDO_KEY_ASSIGN_10 = "Mouse over - Sort 10";
BINDING_NAME_VUHDO_KEY_ASSIGN_11 = "Mouse over - Sort 11";
BINDING_NAME_VUHDO_KEY_ASSIGN_12 = "Mouse over - Sort 12";
BINDING_NAME_VUHDO_KEY_ASSIGN_13 = "Mouse over - Sort 13";
BINDING_NAME_VUHDO_KEY_ASSIGN_14 = "Mouse over - Sort 14";
BINDING_NAME_VUHDO_KEY_ASSIGN_15 = "Mouse over - Sort 15";
BINDING_NAME_VUHDO_KEY_ASSIGN_16 = "Mouse over - Sort 16";

BINDING_NAME_VUHDO_KEY_ASSIGN_SMART_BUFF = "Buff Intelligent";

VUHDO_I18N_MOUSE_OVER_BINDING = "Raccourcis clavier";
VUHDO_I18N_UNASSIGNED = "(non assign\195\169)";

-- #+V1.89
VUHDO_I18N_YES = "Yes";
VUHDO_I18N_NO = "No";
VUHDO_I18N_UP = "up";
VUHDO_I18N_DOWN = "down";
VUHDO_I18N_VEHICLES = "Vehicles";


-- #+v1.94
VUHDO_I18N_DEFAULT_RES_ANNOUNCE = "Come to life, vuhdo, you b00n!";

-- #v+1.151
VUHDO_I18N_MAIN_ASSISTS = "Main Assists";

-- #v+1.169
VUHDO_I18N_O_REALLY = "O'RLY?";

-- #+v1.184
VUHDO_I18N_BW_CD = "CD";
VUHDO_I18N_BW_GO = "GO!";
VUHDO_I18N_BW_LOW = "LOW";
VUHDO_I18N_BW_N_A = "|cffff0000N/A|r";
VUHDO_I18N_BW_RNG_RED = "|cffff0000RNG|r";
VUHDO_I18N_BW_OK = "OK";
VUHDO_I18N_BW_RNG_YELLOW = "|cffffff00RNG|r";

VUHDO_I18N_PROMOTE_RAID_LEADER = "Promote to Raid Leader";
VUHDO_I18N_PROMOTE_ASSISTANT = "Promote to Assistant";
VUHDO_I18N_DEMOTE_ASSISTANT = "Demote from Assistant";
VUHDO_I18N_PROMOTE_MASTER_LOOTER = "Promote to Master Looter";
VUHDO_I18N_MT_NUMBER = "MT #";
VUHDO_I18N_ROLE_OVERRIDE = "Role override";
VUHDO_I18N_MELEE_TANK = "Melee - Tank";
VUHDO_I18N_MELEE_DPS = "Melee - DPS";
VUHDO_I18N_RANGED_DPS = "Ranged - DPS";
VUHDO_I18N_RANGED_HEALERS = "Ranged - Healer";
VUHDO_I18N_AUTO_DETECT = "<auto detect>";
VUHDO_I18N_PROMOTE_ASSIST_MSG_1 = "Promoted |cffffe566";
VUHDO_I18N_PROMOTE_ASSIST_MSG_2 = "|r to assistant.";
VUHDO_I18N_DEMOTE_ASSIST_MSG_1 = "Demoted |cffffe566";
VUHDO_I18N_DEMOTE_ASSIST_MSG_2 = "|r from assistant.";
VUHDO_I18N_RESET_ROLES = "Reset Roles";
VUHDO_I18N_LOAD_KEY_SETUP = "Load Key Setup";
VUHDO_I18N_BUFF_ASSIGN_1 = "Buff |cffffe566";
VUHDO_I18N_BUFF_ASSIGN_2 = "|r has been assigned to |cffffe566";
VUHDO_I18N_BUFF_ASSIGN_3 = "|r";
VUHDO_I18N_RESS_ERR_1 = "Can't resurrect, ";
VUHDO_I18N_RESS_ERR_2 = " has realeased spirit.";
VUHDO_I18N_MACRO_KEY_ERR_1 = "ERROR: Keyboard mouse-over macro size exceeds limit for spell: ";
VUHDO_I18N_MACRO_KEY_ERR_2 = "/256 Characters). Try reducing auto fire options!!!";
VUHDO_I18N_MACRO_NUM_ERR = "Maximum number of macros per character exceeded! Can't create mouse over macro for: ";
VUHDO_I18N_SMARTBUFF_ERR_1 = "VuhDo: Unable to smart buff in combat!";
VUHDO_I18N_SMARTBUFF_ERR_2 = "VuhDo: No buff target available for ";
VUHDO_I18N_SMARTBUFF_ERR_3 = " players out of range for ";
VUHDO_I18N_SMARTBUFF_ERR_4 = "VuhDo: No buff to cast.";
VUHDO_I18N_SMARTBUFF_OKAY_1 = "VuhDo: Buffing |cffffffff";
VUHDO_I18N_SMARTBUFF_OKAY_2 = "|r on ";
VUHDO_I18N_SET_BUFF_TARGET_1 = "Setting buff target for ";
VUHDO_I18N_SET_BUFF_TARGET_2 = " to ";



-- #+v1.189
VUHDO_I18N_UNKNOWN = "unknown";
VUHDO_I18N_SELF = "self";
VUHDO_I18N_MELEES = "Melees";
VUHDO_I18N_RANGED = "Ranged";

VUHDO_I18N_OPTIONS_NOT_LOADED = ">>> VuhDo Options plugin not loaded! <<<";
VUHDO_I18N_SPELL_LAYOUT_NOT_EXIST_1 = "Error: Spell layout \"";
VUHDO_I18N_SPELL_LAYOUT_NOT_EXIST_2 = "\" doesn't exist.";
VUHDO_I18N_AUTO_ARRANG_1 = "Number of Party members has changed to ";
VUHDO_I18N_AUTO_ARRANG_2 = ". Auto-engaging arrangement: \"";

-- #+1.209
VUHDO_I18N_TRACK_BUFFS_FOR = "Track buff for ...";
VUHDO_I18N_OWN_GROUP_LONG = "Own Group";
VUHDO_I18N_NO_FOCUS = "[no focus]";
VUHDO_I18N_NOT_AVAILABLE = "[ N/A ]";
VUHDO_I18N_SHIELD_ABSORPTION = "Shield Status";


-- #+1.237
VUHDO_I18N_TT_DISTANCE = "|cffffb233Distance:|r";
VUHDO_I18N_TT_OF = " of ";
VUHDO_I18N_YARDS = "yards";


-- #+1.252
VUHDO_I18N_PANEL = "Panel";

VUHDO_I18N_BOUQUET_AGGRO = "Flag: Aggro";
VUHDO_I18N_BOUQUET_OUT_OF_RANGE = "Flag: Range, out of";
VUHDO_I18N_BOUQUET_IN_RANGE = "Flag: Range, in";
VUHDO_I18N_BOUQUET_IN_YARDS = "Flag: Distance < yards";
VUHDO_I18N_BOUQUET_OTHER_HOTS = "Flag: Other Player's HoTs";
VUHDO_I18N_BOUQUET_DEBUFF_DISPELLABLE = "Flag: Debuff, Dispellable";
VUHDO_I18N_BOUQUET_DEBUFF_MAGIC = "Flag: Debuff Magic";
VUHDO_I18N_BOUQUET_DEBUFF_DISEASE = "Flag: Debuff Disease";
VUHDO_I18N_BOUQUET_DEBUFF_POISON = "Flag: Debuff Poison";
VUHDO_I18N_BOUQUET_DEBUFF_CURSE = "Flag: Debuff Curse";
VUHDO_I18N_BOUQUET_CHARMED = "Flag: Charmed";
VUHDO_I18N_BOUQUET_DEAD = "Flag: Dead";
VUHDO_I18N_BOUQUET_DISCONNECTED = "Flag: Disconnected";
VUHDO_I18N_BOUQUET_AFK = "Flag: AFK";
VUHDO_I18N_BOUQUET_PLAYER_TARGET = "Flag: Player Target";
VUHDO_I18N_BOUQUET_MOUSEOVER_TARGET = "Flag: Mouseover Single";
VUHDO_I18N_BOUQUET_MOUSEOVER_GROUP = "Flag: Mouseover Group";
VUHDO_I18N_BOUQUET_HEALTH_BELOW = "Flag: Health < %";
VUHDO_I18N_BOUQUET_MANA_BELOW = "Flag: Mana < %";
VUHDO_I18N_BOUQUET_THREAT_ABOVE = "Flag: Threat > %";
VUHDO_I18N_BOUQUET_NUM_IN_CLUSTER = "Flag: Cluster >= #players";
VUHDO_I18N_BOUQUET_CLASS_COLOR = "Flag: Always Class Color";
VUHDO_I18N_BOUQUET_ALWAYS = "Flag: Always Solid";
VUHDO_I18N_SWIFTMEND_POSSIBLE = "Flag: Swiftmend possible";
VUHDO_I18N_BOUQUET_MOUSEOVER_CLUSTER = "Flag: Cluster, Mouseover";
VUHDO_I18N_THREAT_LEVEL_MEDIUM = "Flag: Threat, High";
VUHDO_I18N_THREAT_LEVEL_HIGH = "Flag: Threat, Overnuke";
VUHDO_I18N_BOUQUET_STATUS_HEALTH = "Statusbar: Health %";
VUHDO_I18N_BOUQUET_STATUS_MANA = "Statusbar: Mana %";
VUHDO_I18N_BOUQUET_STATUS_OTHER_POWERS = "Statusbar: non-Mana %";
VUHDO_I18N_BOUQUET_STATUS_INCOMING = "Statusbar: Inc. Heals %";
VUHDO_I18N_BOUQUET_STATUS_THREAT = "Statusbar: Threat %";
VUHDO_I18N_BOUQUET_NEW_ITEM_NAME = "-- enter (de)buff here --";


VUHDO_I18N_DEF_BOUQUET_TANK_COOLDOWNS = "Tank Cooldowns";
VUHDO_I18N_DEF_BOUQUET_PW_S_WEAKENED_SOUL = "PW:S & Weakened Soul";
VUHDO_I18N_DEF_BOUQUET_BORDER_MULTI_AGGRO = "Border: Multi + Aggro";
VUHDO_I18N_DEF_BOUQUET_BORDER_MULTI = "Border: Multi";
VUHDO_I18N_DEF_BOUQUET_BORDER_SIMPLE = "Border: Simple";
VUHDO_I18N_DEF_BOUQUET_SWIFTMENDABLE = "Swiftmendable";
VUHDO_I18N_DEF_BOUQUET_MOUSEOVER_SINGLE = "Mouseover: Single";
VUHDO_I18N_DEF_BOUQUET_MOUSEOVER_MULTI = "Mouseover: Multi";
VUHDO_I18N_DEF_BOUQUET_AGGRO_INDICATOR = "Aggro Indicator";
VUHDO_I18N_DEF_BOUQUET_CLUSTER_MOUSE_HOVER = "Cluster: Mouse Hover";
VUHDO_I18N_DEF_BOUQUET_THREAT_MARKS = "Threat: Marks";
VUHDO_I18N_DEF_BOUQUET_BAR_MANA_ALL = "Manabars: All Powers";
VUHDO_I18N_DEF_BOUQUET_BAR_MANA_ONLY = "Manabars: Mana only";
VUHDO_I18N_DEF_BOUQUET_BAR_THREAT = "Threat: Status Bar";


VUHDO_I18N_CUSTOM_ICON_NONE = "- None / Default -";
VUHDO_I18N_CUSTOM_ICON_GLOSSY = "Glossy";
VUHDO_I18N_CUSTOM_ICON_MOSAIC = "Mosaic";
VUHDO_I18N_CUSTOM_ICON_CLUSTER = "Cluster";
VUHDO_I18N_CUSTOM_ICON_FLAT = "Flat";
VUHDO_I18N_CUSTOM_ICON_SPOT = "Spot";
VUHDO_I18N_CUSTOM_ICON_CIRCLE = "Circle";
VUHDO_I18N_CUSTOM_ICON_SKETCHED = "Sketched";
VUHDO_I18N_CUSTOM_ICON_RHOMB = "Rhomb";


VUHDO_I18N_OUTER_BORDER = "Outer";
VUHDO_I18N_INNER_BORDER = "Inner";
VUHDO_I18N_SWIFTMEND_INDICATOR = "Special Dot";
VUHDO_I18N_MOUSEOVER_HIGHLIGHTER = "Mouseover";
VUHDO_I18N_THREAT_MARKS = "Threat Marks";
VUHDO_I18N_THREAT_BAR = "Threat Bar";
VUHDO_I18N_AGGRO_LINE = "Aggro Line";
VUHDO_I18N_MANA_BAR = "Mana Bar";
VUHDO_I18N_BORDER_WIDTH = "Width";

VUHDO_I18N_ERROR_NO_PROFILE = "Error: No profile named: ";
VUHDO_I18N_PROFILE_LOADED = "Profile successfully loaded: ";
VUHDO_I18N_PROFILE_SAVED = "Successfully saved profile: ";
VUHDO_I18N_PROFILE_OVERWRITE_1 = "Profile";
VUHDO_I18N_PROFILE_OVERWRITE_2 = "is currently owned by\nanother toon";
VUHDO_I18N_PROFILE_OVERWRITE_3 = "\n- Overwrite: Existing profile will be overwritten.\n- Copy: Create and save a copy. Keep existing profile.";
VUHDO_I18N_COPY = "Copy";
VUHDO_I18N_OVERWRITE = "Overwrite";
VUHDO_I18N_DISCARD = "Discard";

-- 2.0, alpha #2
VUHDO_I18N_DEF_BAR_BACKGROUND_SOLID = "Background: Solid";
VUHDO_I18N_DEF_BAR_BACKGROUND_CLASS_COLOR = "Background: Class Color";

-- 2.0 alpha #9
VUHDO_I18N_BOUQUET_DEBUFF_BAR_COLOR = "Flag: Debuff, configured";
VUHDO_I18N_BACKGROUND_BAR = "Bar Background";

-- 2.0 alpha #11
VUHDO_I18N_HEALTH_BAR = "Health Bar";
VUHDO_I18N_DEF_BOUQUET_BAR_HEALTH = "Health Bar: (auto)";
VUHDO_I18N_UPDATE_RAID_TARGET = "Flag: Raid target color";
VUHDO_I18N_BOUQUET_OVERHEAL_HIGHLIGHT = "Color: Overheal Highlighter";
VUHDO_I18N_BOUQUET_EMERGENCY_COLOR = "Color: Emergency";
VUHDO_I18N_BOUQUET_HEALTH_ABOVE = "Flag: Health > %";
VUHDO_I18N_BOUQUET_RESURRECTION = "Flag: Resurrection";
VUHDO_I18N_BOUQUET_STACKS_COLOR = "Color: #Stacks";

-- 2.1
VUHDO_I18N_DEF_BOUQUET_BAR_HEALTH_SOLID = "Health: (generic, solid)";
VUHDO_I18N_DEF_BOUQUET_BAR_HEALTH_CLASS_COLOR = "Health: (generic, class col)";

-- 2.9
VUHDO_I18N_NO_TARGET = "[no target]";
VUHDO_I18N_TT_LEFT = " Left: ";
VUHDO_I18N_TT_RIGHT = " Right: ";
VUHDO_I18N_TT_MIDDLE = " Middle: ";
VUHDO_I18N_TT_BTN_4 = " Button 4: ";
VUHDO_I18N_TT_BTN_5 = " Button 5: ";
VUHDO_I18N_TT_WHEEL_UP = " Wheel up: ";
VUHDO_I18N_TT_WHEEL_DOWN = " Wheel down: ";


-- 2.13
VUHDO_I18N_BOUQUET_CLASS_ICON = "Icon: Class";
VUHDO_I18N_BOUQUET_RAID_ICON = "Icon: Raid target";
VUHDO_I18N_BOUQUET_ROLE_ICON = "Icon: Role";

-- 2.18
VUHDO_I18N_LOAD_PROFILE = "Load Profile";

-- 2.20
VUHDO_I18N_DC_SHIELD_NO_MACROS = "No free macro slots for this toon... d/c shield temporarily disabled.";
VUHDO_I18N_BROKER_TOOLTIP_1 = "|cffffff00Left Click|r to show options menu";
VUHDO_I18N_BROKER_TOOLTIP_2 = "|cffffff00Right Click|r to show popup menu";
