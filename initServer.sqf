_handle = execVM "initVariables.sqf";
waitUntil{scriptDone _handle};

if (CONVERT_EDEN_UNITS == 1) then {
	call BM_fnc_convertEdenUnits;
};