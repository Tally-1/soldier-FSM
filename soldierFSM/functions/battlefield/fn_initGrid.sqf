params["_battlefield"];
private _startTime     = time;
private _areaName      = _battlefield get "name";
private _hashmap       = createHashmap;
private _gridVarName   = [_areaName, "Battle_", "_Grid"] call Tcore_fnc_stringToVarName;
private _centerPos     = _battlefield get "center";
private _size          = (_battlefield get "radius")*2.5;
private _gridPositions = [_centerPos, _size] call Tcore_fnc_grid100Pos;

private _clusterHash   = _battlefield get "clusterPositions";

private _westPositions = _clusterHash get "west";
private _eastPositions = _clusterHash get "east";
private _guerPositions = _clusterHash get "independent";

private _hiddenFromWest = [];
private _hiddenFromEast = [];
private _hiddenFromGuer = [];

{
	private _westVisible = [_x, _westPositions] call Tcore_fnc_visibleFromPositions;
	private _eastVisible = [_x, _eastPositions] call Tcore_fnc_visibleFromPositions;
	private _guerVisible = [_x, _guerPositions] call Tcore_fnc_visibleFromPositions;

	if!(_westVisible)then{_hiddenFromWest pushBackUnique _x};
	if!(_eastVisible)then{_hiddenFromEast pushBackUnique _x};
	if!(_guerVisible)then{_hiddenFromGuer pushBackUnique _x};

} forEach _gridPositions;

_hashmap set ["gridPositions",  _gridPositions ];
_hashmap set ["hiddenFromWest", _hiddenFromWest];
_hashmap set ["hiddenFromEast", _hiddenFromEast];
_hashmap set ["hiddenFromGuer", _hiddenFromGuer];


missionNamespace setVariable [_gridVarName, _hashmap];

_battlefield set ["grid", _gridVarName];
_battlefield set ["gridLoaded", true];

private _timeToInit = time - _startTime;

[["grid was initialized in ", _timeToInit, "seconds"]] call dbgmsg;

true;