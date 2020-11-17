/* Main function that takes care of setting up loadouts for a spawned unit.
	INPUT: 
		0: _unit, who was spawned; type Object
		1: _type, unit type; type String
	OUTPUT: true, function ran successfully; type Boolean
*/

params [
	["_unit", objNull, [objNull]],
	["_type", "", ["string"]]
];

if (isNull _unit) exitWith {};

// Set variable scope
private["_type"];

// If type wasn't given then find it based on the unit and use that to define the loadout type
if (_type == "" and typeOf _unit in USED_UNITS) then {
	_index = USED_UNITS find (typeOf _unit);
	_unitType = USED_UNITS select _index;

	if ("akm" in _unitType) then {
		_type = "scav";
	};

	if ("machinegunner" in _unitType) then {
		_type = "scav_heavy";
	};

	if ("squadleader" in _unitType) then {
		_type = "boss";
	};

	if ("army" in _unitType && "rifleman" in _unitType && "rhsusf" in _unitType) then {
		_type = "USEC";
	};

};

_loadout = _type call BM_fnc_randomLoadout; // Returns a random loadout with the desired type
_unit setUnitLoadout _loadout;

// Skip bosses
if (_type != "boss") then {
	_unit call BM_fnc_addMagazines;
};
