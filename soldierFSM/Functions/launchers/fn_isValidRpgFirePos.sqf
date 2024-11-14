params[
    ["_firePosASL",   nil,      [[]]],
    ["_targetPosASL", nil,      [[]]],
    ["_shooter",      nil, [objNull]],
    ["_targetObj",    nil, [objNull]]
];
private _validPos = false;

isNil{//Unscheduled execution for better performance.

if(_firePosASL distance2D _targetObj < 20)exitWith{};

private _topPos     = _firePosASL vectorAdd [0, 0, 5];
private _linebreaks = lineIntersectsSurfaces [_firePosASL, _topPos, _shooter, objNull, true, 3];
private _buildings  = _linebreaks select {(_x#3) isKindOf "house"};
if(_buildings isNotEqualTo [])exitWith{};

private _noLOS = [_firePosASL, _targetPosASL, [_shooter, _targetObj]] call SFSM_fnc_lineBroken;
if(_noLOS)exitWith{};

_validPos = true;
};

_validPos;