/* Regenerates loadouts for all units on the map
	INPUT: 
		0: - -
	OUTPUT: true, the finalised loadout; type Boolean
*/

{
	if (typeOf _x in USED_UNITS) THEN {
		_x call BM_fnc_spawnUnit;
	};
} forEach allUnits;

true