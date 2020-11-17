_found = [false, []];

if (ALLSETTLEMENTS isEqualTo []) exitWith {_found};
_house = param [0, objNull, [objNull]];

if (isNull _house) exitWith {};

/*
{
	{
		if (!(_house in _x)) exitWith {_found = true};
	} forEach _x; // Check every index on the settlement
} forEach ALLSETTLEMENTS; // For all settlements*/

_counter = 0;
{
	_index = _x find _house;
	if (_index != -1) exitWith {_found = [true, [_counter, _index]];};
	_counter = _counter + 1;
} forEach ALLSETTLEMENTS; // For all settlements

// [_counter, _index] == [settlement, house index in settlement]

_found