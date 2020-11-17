/* Returns a random loadout with the desired type
	INPUT: 
		1: _type, type of loadout; type String;
		   possible values: "scav", "scav_heavy", "boss"
	OUTPUT: _loadout, the finalised loadout; type Array
*/

_type = param [0, "", ["string"]];
if (isNull _unit) exitWith {};

//Define variables 
private["_loadout", "_magClasses"];
_primary = "";
_secondary = "";

// IF THE UNIT IS A CHDKZ RIFLEMAN (AKM)
if (_type == "scav") then {
	// Randomise clothing
	_clothing = selectRandom SCAV_CLOTHING;
	_vest = selectRandom SCAV_VESTS;
	_helmet = selectRandom SCAV_HELMETS;
	_backpack = selectRandom SCAV_BACKPACKS;
	_face = selectRandom SCAV_FACE;

	//Randomise either a primary weapon or a secondary, percentage. Default: 20
	if ((floor random 101) <= 30) then {
		_secondary = selectRandom SCAV_SECONDARIES;
	} else {
		_primary = selectRandom SCAV_PRIMARIES;
	};

	// Consolidate loadout into one variable
	_loadout =
	[
		/* primary weapon */	[_primary, "", "", "", [], [], ""],
		/* launcher */			["", "", "", "", [], [], ""],
		/* handgun weapon */	[_secondary, "", "", "", [], [], ""],
		/* uniform */			[_clothing, [["FirstAidKit", floor random 3]]],
		/* vest */				[_vest, []],
		/* backpack */			[_backpack,[]],
		/* items */				_helmet, _face,[],
		/* items */				["ItemMap","","","ItemCompass","ItemWatch",""]
	];
};

// HEAVY SCAV
if (_type == "scav_heavy") then {
	// Randomise clothing
	_clothing = selectRandom SCAV_CLOTHING;
	_vest = selectRandom SCAV_VESTS;
	_helmet = selectRandom SCAV_HELMETS;
	_backpack = selectRandom SCAV_BACKPACKS;
	_face = selectRandom SCAV_FACE;

	//Heavy scavs always have a primary
	_primary = selectRandom SCAV_PRIMARIES;

	// Consolidate loadout into one variable
	_loadout =
	[
		/* primary weapon */	[_primary, "", "", "", [], [], ""],
		/* launcher */			["", "", "", "", [], [], ""],
		/* handgun weapon */	[_secondary, "", "", "", [], [], ""],
		/* uniform */			[_clothing, [["FirstAidKit", floor random 3]]],
		/* vest */				["V_PlateCarrierIAGL_oli", []],
		/* backpack */			[_backpack,[]],
		/* items */				"rhsusf_mich_bare_norotos_arc_alt_headset", _face,[],
		/* items */				["ItemMap","","","ItemCompass","ItemWatch",""]
	];
};

// BOSS
if (_type == "boss") then {

	// Killa will kill you :D
	_loadout = [["arifle_RPK12_F","","","rhs_acc_1p87",["hlc_75Rnd_762x39_b_rpk",75],[],""],[],["hlc_pistol_P229R_40Elite","","hlc_acc_TLR1","HLC_Optic228_Docter_CADEX",["hlc_12Rnd_40SW_B_P226",12],[],""],["UK3CB_CHC_C_U_COACH_04",[["FirstAidKit",1],["Chemlight_blue",1,1],["rhs_mag_f1",2,1]]],["LOP_V_Chestrig_Black",[["hlc_75Rnd_762x39_b_rpk",2,75]]],["B_AssaultPack_blk",[["rhs_mag_f1",6,1]]],"rhs_altyn_visordown","rhs_balaclava",["Binocular","","","",[],[],""],["ItemMap","","","ItemCompass","ItemWatch",""]];
	_unit setName "Killa";
};

// USEC
if (_type == "USEC") then {
	// Randomise clothing
	_clothing = selectRandom USEC_CLOTHING;
	_vest = selectRandom USEC_VESTS;
	_helmet = selectRandom USEC_HELMETS;
	_backpack = selectRandom USEC_BACKPACKS;
	_face = selectRandom USEC_FACE;

	_primary = selectRandom USEC_PRIMARIES;

	// Consolidate loadout into one variable
	_loadout =
	[
		/* primary weapon */	[_primary, "", "", "", [], [], ""],
		/* launcher */			["", "", "", "", [], [], ""],
		/* handgun weapon */	["", "", "", "", [], [], ""],
		/* uniform */			[_clothing, [["FirstAidKit", floor random 3]]],
		/* vest */				[_vest, []],
		/* backpack */			[_backpack,[]],
		/* items */				_helmet, _face,[],
		/* items */				["ItemMap","","","ItemCompass","ItemWatch",""]
	];
};
// Return value
_loadout