params  ["_man"];
private ["_pos"];
private _fipo        = [_man] call SFSM_fnc_getFipo;
private _battleField = [_man] call SFSM_fnc_getBattlefield;
private _sqfmFnc     = !isNil "SQFM_fnc_zoneSuppressionTargets";

if(_sqfmFnc)            exitWith{[_man, _fipo] call SFSM_fnc_SQFSM_getSuppressionTargetFipo};
if(isNil "_battleField")exitWith{};

private _clusterData   = missionNamespace getVariable (_battlefield get "clusterData");
if(isNil "_clusterData")exitWith{};

isNil{//Forced unscheduled execution
private _knowledgeNeeded = _fipo getVariable "minSupKnow";
private _enemyClusters   = _clusterData select { 
	_x params [
		["_Returnpos",        nil, [[]]],
		["_clusterObjects",   nil, [[]]],
		["_clusterRadius",     nil, [0]],
		["_side",           nil, [east]]
	];
	
	private _menInCluster = _clusterObjects select {_x isKindOf "caManBase"};
	private _isEnemy      = [_man, _menInCluster] call SFSM_fnc_validEnemyInArr;
	private _knowledgeArr = _menInCluster apply {_man knowsAbout _x};
	private _knowledge    = selectMax _knowledgeArr;
	private _known        = _knowledge >= _knowledgeNeeded;

	_isEnemy
	&&{_known};
};

private _enemyPositions = _enemyClusters apply {ATLToASL(_x#0);};

if(_enemyPositions isEqualTo [])exitWith{};

private _validPositions = _enemyPositions select {[(aimPos _man), _x] call Tcore_fnc_visibility > 0;};

if(_validPositions isEqualTo [])then{
	_validPositions = _enemyPositions apply {[_x, 10] call Tcore_fnc_addZ;};
};


private _sortVisDist = {
	private _v = [(aimPos _man), _x] call Tcore_fnc_visibility;
	private _d = _man distance _x;

	if(_v isEqualTo 0)
	then{_v = 0.0001;};

	private _value = _d/_v;
	_value;
};

_pos = ([_validPositions, [], _sortVisDist, "ASCEND"] call BIS_fnc_sortBy)#0;

};//unscheduled execution end.

if(isNil "_pos")exitWith{
	// _pos = [(_fipo modelToWorldVisualWorld [0,3,0]), 1.5] call Tcore_fnc_addZ;
	nil;
};

_pos;