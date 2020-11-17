MAP_ANALYSED = false;
DYNAMIC_GROUPS = [];

_handle = execVM "initVariables.sqf";
waitUntil{scriptDone _handle};

if (CONVERT_EDEN_UNITS == 1) then {
	call BM_fnc_convertEdenUnits;
};

if (BI_DYNAMIC_SIMULATION) then {
	execVM "scripts\enableDynamicSimulation.sqf";
};

[] spawn BM_fnc_analyseMap;

// Spawn a thread that waits for map analysis
[] spawn {
	//waitUntil{MAP_ANALYSED};
	execVM "scripts\startAI.sqf";
};