/* Give given unit the desired amount of magaziens. Gives a random magazine Detectects comaptible magazine types automaically and randomises 
	INPUT: 
		0: _unit, who to give the magazines to; type Object
		1 (Optional): _amount, amount of mags to give; type Scalar
	OUTPUT:
		0: true, function ran successfully; type Boolean
	PROBLEMS: Since the function checks for all weapons. It will add launcher ammo in unrealistic amounts
*/

// variable name, default value, compatible data type, allowed input array length ranges
params [
	["_unit", objNull, [objNull]],
	["_amount", 0, [1, []], 3],
	["_magazines", [], ["", []], [1,2,3]]
];

_weapons = weapons _unit;

private["_magCount", "_mag"];
_counter = 0;
{
	// Get an array of suitable magazines and select a random one
	_magClasses = getArray (configFile / "CfgWeapons" / _x / "magazines"); 
	_mag = selectRandom _magClasses;

	// If an amount was not specified, randomise with default values.
	if (_amount isEqualTo [] or _amount isEqualTo 0) then {
		_magCount = floor random [3,6,11];
	} else {
		_magCount = floor random _amount;
	};
	
	// Give magazines
	for "_i" from 1 to _magCount do
	{
		_unit addMagazine _mag;
	};

	_counter = _counter + 1;
} forEach _weapons; //Repeat for each weapon the unit has

true