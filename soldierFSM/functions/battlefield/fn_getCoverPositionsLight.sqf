params["_battlefield"];
private _sides = (_battlefield get "sides") call SFSM_fnc_sidesFromString;
private _coverPositionsLight = createHashmap;
if(count _sides < 2)exitWith{_coverPositionsLight};

private _clusterData      = missionNamespace getVariable (_battlefield get "clusterData");
private _mapObjects       = missionNamespace getVariable (_battlefield get "mapObjects");
private _clusterPositions = (_battlefield get "clusterPositions");

private _coverPositionsWest = [];
private _coverPositionsEast = [];
private _coverPositionsGuer = [];
private _allPositions       = []; 
private _isBuilding = {_x isKindOf "house" && {count ([_x] call BIS_fnc_buildingPositions) > 3}};

// private _buildings = _mapObjects select _isBuilding;

{
	private _sideAndPos  = [_x, _mapObjects, _clusterPositions] call SFSM_fnc_clusterCoverPosLight;
	private _side      = _sideAndPos#0;
	private _positions = _sideAndPos#1;



	_allPositions append _positions;

	if(_side == west)       then{_coverPositionsWest append _positions};
	if(_side == east)       then{_coverPositionsEast append _positions};
	if(_side == independent)then{_coverPositionsGuer append _positions};

} forEach _clusterData; 

/*
private _blockedPositions = [_allPositions] call SFSM_fnc_excludeCpos;

{
	_coverPositionsWest deleteAt (_coverPositionsWest find _x);
	_coverPositionsEast deleteAt (_coverPositionsEast find _x);
	_coverPositionsGuer deleteAt (_coverPositionsGuer find _x);
} forEach _blockedPositions;
*/
_coverPositionsLight set ["west", 		 _coverPositionsWest];
_coverPositionsLight set ["east", 		 _coverPositionsEast];
_coverPositionsLight set ["independent", _coverPositionsGuer];

_battlefield set ["coverPositions", _coverPositionsLight];
// _battlefield set ["buildings", _buildings];

_coverPositionsLight