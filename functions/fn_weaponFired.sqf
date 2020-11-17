// Gets run on the server when a player shoots a weapon
params [
	["_unit", objNull, [objNull]],
	["_pos", [], [[]]]
];

if (isNull _unit or (_pos isEqualTo [])) exitWith {diag_log format ["BM_fnc_weaponFired | ERROR: Cannot find source of gunfire. Unit: %1 Pos: %2", _unit, _pos]};

{
	//_leader = leader _x;
	if (_unit distance (leader _x) < GUNFIRE_DETECTION_RANGE) then {
		if (random 101 < HEAR_CHANCE) then {
			_x move _pos;
		};
	};
} forEach DYNAMIC_GROUPS;