_wSize = worldSize;

_squareSize = 1000; // Define size of the chunks that will be analyzed. Default: 1000 (1km)
_settlementRadius = 100;
ALLSETTLEMENTS = [];
_circleRadius = sqrt (2 * _squareSize ^ 2); //Use pythagorean theorem to get the ideal circle radius

if (BM_DEBUG) then {
	diag_log "------------------------------------------"
	diag_log "BM_fnc_analyzeMap | STARTING MAP ANALYSIS";
	diag_log "------------------------------------------"
};

// Form a loop that will check every chunk in the map
for "_w" from _squareSize / 2 to _wSize + _squareSize step 1000 do { 
	for "_h" from _squareSize / 2 to _wSize + _squareSize step 1000 do { 
		_pos = [_w, _h, 0];
		_markerstr = createMarker [str _pos, _pos];
		_markerstr setMarkerShape "RECTANGLE";
		_markerstr setMarkerBrush "Grid";
		_markerstr setMarkerAlpha 0.2;
		_markerstr setMarkerSize [500, 500];
		_markerstr setMarkerColor "ColorRed";

		_objects = nearestTerrainObjects [_pos, ["HOUSE"], _circleRadius, false, true];

		_newSettlement = [];
		private["_house", "_index"];

		if (BM_DEBUG) then {diag_log "BM_fnc_analyzeMap | CHUNK: Starting chunk analysis"};

		// If houses were found
		if (!(_objects isEqualTo [])) then {
			if (BM_DEBUG) then {diag_log format ["BM_fnc_analyzeMap | Houses found at [%1, %2]. Starting analyzation.", _w, _h]};

			{
				_house = _x;
				_pos = getPos _house;
				
				// If no settlements have been established yet (first house in the map) -> Skip checking
				if (ALLSETTLEMENTS isEqualTo []) then {
					_newSettlement pushBack _house;
					if (BM_DEBUG) then {diag_log format ["BM_fnc_analyzeMap | House %1 was the first house to be analyzed. Pushed into newSettlement.", _house];};
				} else {
					//If house is already in a settlement then skip, if house isn't in one then continue
					if (!((_house call BM_fnc_inSettlement) select 0)) then {
						// Check all nearby houses and their settlements in order starting from the closest
						_nearHouses = nearestTerrainObjects [_pos, ["HOUSE"], _settlementRadius, true, true];

						// If there are no houses nearby then simply add it to the new array
						if (_nearHouses isEqualTo []) then {
							_newSettlement pushBack _house;
							if (BM_DEBUG) then {diag_log format ["BM_fnc_analyzeMap | House %1 didn't have buildings near it. Pushed into newSettlement", _house];};
						} else { //For each house near the current one, check if they belong to a settlement
							{
								_nearHouse = _x;
								_check = _nearHouse call BM_fnc_inSettlement; //Check if in settlement and store results

								// If a nearby house is already in a settlement
								if ((_nearHouse call BM_fnc_inSettlement) select 0) exitWith {
									_index = (_check select 1) select 0;
									_settlement = ALLSETTLEMENTS select _index;

									_settlement pushBackUnique _house; //Pushback the house we were originally checking into the nearby house's settlement and exit the forEach loop

									if (BM_DEBUG) then {diag_log format ["BM_fnc_analyzeMap | House %1 pushed into existing settlement at index %1", _house, _index];};
								};

								if (true) exitWith {_newSettlement pushBack _house}; // If house isn't in a settlement

							} forEach _nearHouses; 
						};
						if (BM_DEBUG) then {diag_log format ["BM_fnc_analyzeMap | ERROR: House %1 was skipped. House somehow squeezed itself through the algorithm. GO FIX IT!", _house, _index];};
					};
					if (BM_DEBUG) then {diag_log format ["BM_fnc_analyzeMap | House %1 was already in a settlement. House skipped", _house];};
				};
			} forEach _objects; //For each building found in the chunk
		};

		// If chuck wasn't empty and a newsettlement was established, add it to the array of settlements
		if (!(_newSettlement isEqualTo [])) then {
			ALLSETTLEMENTS pushBack _newSettlement;
			if (BM_DEBUG) then {diag_log format ["BM_fnc_analyzeMap | CHUNK DONE: A new settlement has been formed. Pushback into ALLSETTLEMENTS. Current index %1.", count ALLSETTLEMENTS - 1];};
		} else {
			if (BM_DEBUG) then {diag_log "BM_fnc_analyzeMap | CHUNK DONE: Chunk was empty.";};
		};

		
		//[pos, _color] call BM_fnc_drawDot;

	};
		
};

if (BM_DEBUG) then {diag_log format ["BM_fnc_analyzeMap | COMPLETE: Analysis finished. Total settlements: %1.", count ALLSETTLEMENTS];};
if (BM_DEBUG) then {diag_log format ["BM_fnc_analyzeMap | STARTING: Adding debug markers", count ALLSETTLEMENTS];};

if (BM_DEBUG) then {
	_colors = ["ColorBlack", "ColorGrey", "ColorRed", "ColorBrown", "ColorOrange", "ColorYellow", "ColorKhaki", "ColorGreen", "ColorBlue", "ColorPink", "ColorWhite"];
	{
		_color = selectRandom _colors;
		{
			_pos = getPos _x;
			_markerstr = createMarker [str _pos, _pos];
			_markerstr setMarkerType "mil_dot";
			_markerstr setMarkerColor _color;
		} forEach _x;
	} forEach ALLSETTLEMENTS;
};

if (BM_DEBUG) then {diag_log format ["BM_fnc_analyzeMap | COMPLETE: Debug markers added.", count ALLSETTLEMENTS];};

if (BM_DEBUG) then {
	diag_log "------------------------------------------"
	diag_log "BM_fnc_analyzeMap | MAP ANALYSIS FINISHED";
	diag_log "------------------------------------------"
};