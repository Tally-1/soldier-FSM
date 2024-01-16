params[
    ["_man",       nil, [objNull]],
    ["_startPos",  nil,      [[]]],
    ["_startTime", nil,       [0]]
];
private _timeSinceStart = time - _startTime;

if!([_man, true] call SFSM_fnc_canRun) exitWith{false;};
if(_timeSinceStart < 2)                exitWith{false;};
if(_timeSinceStart > 10)               exitWith{false;};

private _hasProned = _man getVariable "SFSM_UnitData" get "hasForcedMoveProned";
private _distance  = _man distance2D _startPos;

if(_hasProned)    exitWith{false;};
if(_distance > 1) exitWith{false;};

[_man, "amovppnemstpsraswrfldnon"] remoteExecCall ["playMoveNow", _man];
[_man, "DOWN"]                     remoteExecCall ["setUnitPos",  _man];

_man getVariable "SFSM_UnitData"set["hasForcedMoveProned", true];

_man spawn {
    sleep 3;
    _this setUnitPos "AUTO";
};

true;