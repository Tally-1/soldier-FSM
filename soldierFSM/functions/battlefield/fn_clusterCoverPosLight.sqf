Params["_clusterData", "_mapObjects", "_clusterPositions"];

private _clusterPos   = _clusterData#0;
private _size         = _clusterData#2;
private _side         = _clusterData#3;
private _searchRadius = (selectMax[_size, SFSM_DodgeDistance]);
private _objectPositions = _mapObjects get "positions";
private _nearObjPos = _objectPositions inAreaArray [_clusterPos, _searchRadius, _searchRadius];
private _coverPositions = [];

private _enemyPosArr = (_clusterPositions get "east") + (_clusterPositions get "independent");

if(_side == east)       then{_enemyPosArr = (_clusterPositions get "west") + (_clusterPositions get "independent")};
if(_side == independent)then{_enemyPosArr = (_clusterPositions get "east") + (_clusterPositions get "west")};

{
	private _key = str _X;
	private _objectShape = (_mapObjects get _key) get "3dData";
	private _coverPosArr = [_enemyPosArr, _objectShape] call Tcore_fnc_objCoverPosLight;
	private _coverPos    = _coverPosArr#0;
	private _nearestPos  = [_coverPos, _coverPositions] call Tcore_fnc_nearestPos; 
	private _found       = !(typeName _nearestPos == "SCALAR");
	private _distance    = 3;

	if(_found)then{_distance = (_coverPos distance2D _nearestPos)};

	if(_distance > 1.2)
	then{_coverPositions pushback _coverPos};	

} forEach _nearObjPos;

 
[_side, _coverPositions]