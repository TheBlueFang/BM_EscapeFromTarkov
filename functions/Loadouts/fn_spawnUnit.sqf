/* Main function that takes care of setting up loadouts for a spawned unit.
	INPUT: 
		0: _unit, who was spawned; type Object
		1: _type, unit type; type String
	OUTPUT: true, function ran successfully; type Boolean
*/

_unit = param [0, objNull, [objNull]];
if (isNull _unit) exitWith {};

// Set variable scope
private["_type"];

// Find the unit type and use that to define the loadout type
if (typeOf _unit in USED_UNITS) then {
	_unitType = USED_UNITS select (USED_UNITS find (typeOf _unit));

	if ("akm" in _unitType) then {
		_type = "scav";
	};

	if ("machinegunner" in _unitType) then {
		_type = "scav_heavy";
	};

	if ("squadleader" in _unitType) then {
		_type = "boss";
	};

};

_loadout = _type call BM_fnc_randomLoadout; // Returns a random loadout with the desired type
_unit setUnitLoadout _loadout;

// Skip bosses
if (_type != "boss") then {
	[_unit] call BM_fnc_addMagazines;
};
