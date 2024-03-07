params [
        ["_posASL",   nil, [[],objNull]],
        ["_radius",   nil,          [0]],
		["_dir",      nil,          [0]],
        ["_posCount", 8,            [0]]    
];

if(typeName _posASL isEqualTo "OBJECT")then{
	if  (isNil "_dir")
	then{_dir = getDirVisual _posASL;};

	private _object = _posASL;
	_posASL = getPosASLVisual _object;

	if  (_object isKindOf "caManBase")
	then{_posASL = aimpos _object;};
};

private _positions    = [];
private _dirIncrement = (360 / _posCount);
private _z            = _posASL#2;

for "_i" from 0 to (_posCount -1)
do {
        private _newPos = [_posASL, _dir, _radius, _z] call SFSM_fnc_sinCosPos2;
        _positions pushBack _newPos;
        _dir = _dir + _dirIncrement;
		_dir = [_dir, false] call Tcore_fnc_formatDir;
   };

_positions;