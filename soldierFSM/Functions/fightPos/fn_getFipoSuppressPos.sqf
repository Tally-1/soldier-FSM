params ["_man"];
private _fipo        = [_man] call SFSM_fnc_getFipo;
private _battleField = [_man] call SFSM_fnc_getBattlefield;
private _pos         = [(_fipo modelToWorldVisualWorld [0,3,0]), 1.5] call Tcore_fnc_addZ;

if(isNil "_battleField")exitWith{_pos;};

private _clusterData   = missionNamespace getVariable (_battlefield get "clusterData");
if(isNil "_clusterData")exitWith{_pos;};

isNil{//Forced unscheduled execution

private _enemyClusters = _clusterData select {
	private _side     = _x#3;
	private _friendly = [(side _man), _side] call BIS_fnc_sideIsFriendly;
	_friendly isEqualTo false;
};

private _enemyPositions = _enemyClusters apply {ATLToASL(_x#0);};

private _sortVisDist = {
	private _v = [(aimPos _man), _x] call Tcore_fnc_visibility;
	private _d = _man distance _x;
	if(_v isEqualTo 0)then{_v = 0.0001;};
	private _value = _d/_v;
	_value;
};

_pos = ([_enemyPositions, [], _sortVisDist, "ASCEND"] call BIS_fnc_sortBy)#0;

};//unscheduled execution end.

_pos;