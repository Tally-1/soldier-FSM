params[
    ["_shooter",  nil, [objNull]],
    ["_building", nil, [objNull]],
    ["_minHeight", 1.2,      [0]]
];
private _centerPosASL  = [_building] call SFSM_fnc_buildingCenterPosASL;
private _targetMan = _shooter getVariable ["SFSM_prevTarget", objNull];
if!([_shooter, _targetMan] call SFSM_fnc_validEnemy)exitWith{_centerPosASL;};

private _targetBuilding = [_targetMan] call SFSM_fnc_currentBuilding;
if(isNil "_targetBuilding")      exitWith{_centerPosASL;};
if(_targetBuilding != _building) exitWith{_centerPosASL;};

private _startPos = eyePos _targetMan;
private _endPos   = [_startPos, aimpos _shooter, 10] call SFSM_fnc_posOnvector;
private _z        = selectMax [_startPos#2, _endPos#2];

_endPos = [_endPos#0, _endPos#1, _z];

private _surfaces = (lineIntersectsSurfaces [_startPos, _endPos, _targetMan, objNull, false, 3, "GEOM", "FIRE", true])select{_x#3 isEqualTo _building;};
if(_surfaces isEqualTo [])exitWith{_centerPosASL;};

private _surfaceData     = _surfaces#0;
private _intersectPosASL = _surfaceData#0;
private _altitude        = (ASLToATL _intersectPosASL)#2;

if(_altitude < _minHeight)exitWith{_centerPosASL};

_intersectPosASL;