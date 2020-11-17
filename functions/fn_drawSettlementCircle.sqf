params [
	["_houses", [], [[]]],
	["_color", "", ["string"]]
];

if (_color == "" or (_houses isEqualTo [])) exitWith {
	diag_log format ["BM_fnc_drawSettlementCircle | ERROR: Could not draw circle with color %1 at targets %1", _color, _houses];
};

_minX = 9000000;
_maxX = 0;
_minY = 9000000;
_maxY = 0;

{
	_pos = getPos _x;
	
	_xVal = _pos select 0;
	_minX = [_minX, _xVal] select (_xVal  < _minX);
	_maxX = [_maxX, _xVal] select (_xVal  > _maxX);

	_yVal = _pos select 1;
	_minY = [_minY, _yVal] select (_yVal < _minY);
	_maxY = [_maxY, _yVal] select (_yVal > _maxY);

} forEach _houses;

hint format ["%1, %2 ; %3, %4", _minX, _maxX, _minY, _maxY];

_markerPos = [(_minX + _maxX) / 2, (_minY + _maxY) / 2, 0];
_markerstr = createMarker [str _markerPos, _markerPos];
_markerstr setMarkerShape "ELLIPSE";
_markerstr setMarkerBrush "Border";
_markerstr setMarkerAlpha 1;
_markerstr setMarkerSize [abs(_minX - _maxX) / 2, abs(_minY - _maxY) / 2];
_markerstr setMarkerColor _color;

_markerstr setMarkerPos _markerPos;