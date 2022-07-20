params["_battlefield"];

_battlefield set ["currentAction",	"updating grid"];
private _gridHash      = missionNamespace getVariable (_battlefield get "grid");
private _gridPositions = _gridHash get "gridPositions";
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


_gridHash set ["hiddenFromWest", _hiddenFromWest];
_gridHash set ["hiddenFromEast", _hiddenFromEast];
_gridHash set ["hiddenFromGuer", _hiddenFromGuer];

_battlefield set ["currentAction",	"none"];

true;