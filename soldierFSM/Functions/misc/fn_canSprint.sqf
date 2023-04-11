private _maxDist = 100;
private _minDist = 3;
params ["_man", "_pos", "_maxDist", "_minDist"];
if(isNil "_man")                                   exitwith{false;};
if(isNil "_pos")                                   exitwith{false;};
if(_man in allPlayers)                             exitwith{false;};
if(_man distance2D _pos < _minDist)                exitWith{false;};
if(_man distance2D _pos > _maxDist)                exitWith{false;};
if(! ([_man] call SFSM_fnc_isRealMan))             exitwith{false;};
if(count SFSM_sprinters >= SFSM_maxSprinters)      exitWith{false;};
if(_man getVariable ["SFSM_Sprinting", false])     exitwith{false;};
if(_man getVariable ["ace_isunconscious", false])  exitWith{false;};
if(_man getVariable ["dam_ignore_injured0",false])exitWith{false;};
if!([_man, "pathEnabeled"] call SFSM_fnc_unitData) exitWith{false;};

private _action = [_man, "action"] call SFSM_fnc_unitData;
if(isNil "_action")                                exitWith{false;};
if("CQB" in _action)                               exitWith{false;};

private _lastLosCheck = [_man, "lastSprintCheck"] call SFSM_fnc_unitData;
if(time - _lastLosCheck < 2)exitWith{false;};



private _manPos = getPos _man;
private _aimPos = AGLToASL [_manPos#0, _manPos#1, 0.7];
private _ASLPos = AGLToASL [_pos#0, _pos#1, 0.7];

private _objsInPath = lineIntersectsObjs [_aimPos, _ASLPos, _man, objNull, true, 2];

_objsInPath = _objsInPath select {
	private _notMan  = !(_x isKindOf "man");
	private _notBush = !((([_x] call SFSM_fnc_terrainObjData)get "type")in SFSM_treeTypes);
	(_notMan && {_notBush});
};

[_man, "lastSprintCheck", time] call SFSM_fnc_unitData;

if(count _objsInPath > 0)exitWith{false;};

true;