params [
	["_type", "", ["string"]],
	["_pos", [], [[]]]
];

if (_type == "" or (_pos isEqualTo [])) exitWith {
	diag_log format ["BM_fnc_spawnGroup | ERROR: Could not create group with parameters type: %1 and pos: %2", _type, _pos];
};

private ["_group"];
if (_type isEqualTo "scav") then {
	_size = (SCAV_GROUP_SIZE select 0) + floor random ((SCAV_GROUP_SIZE select 1) - 1);

	_group = createGroup independent;
	for "_i" from 0 to _size do {
		_unit = _group createUnit ["rhsgref_ins_g_rifleman_akm", _pos, [], 10, "NONE"];
		[_unit, _type] spawn BM_fnc_setLoadout;
	};
};

if (BI_DYNAMIC_SIMULATION) then {
	DYNAMIC_GROUPS pushBack _group;
	_group enableDynamicSimulation true;
};