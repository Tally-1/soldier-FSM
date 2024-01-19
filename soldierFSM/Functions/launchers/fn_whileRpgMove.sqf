params[
    ["_moveScript",     nil, [scriptNull]],
    ["_timeLimit",      nil,          [0]],
    ["_man",            nil,    [objNull]],
    ["_targetBuilding", nil,    [objNull]]
];
private _moveAborted = [_man, "abortForcedMove"] call SFSM_fnc_unitData;

if(_moveAborted)        exitWith{true;};
if(isNil "_moveScript") exitWith{true;};
if(scriptDone _move)    exitWith{true;};
if(time > _timeLimit)   exitWith{true;};

private _canShoot = [_man, _targetBuilding] call SFSM_fnc_atValidRpgFirePos;

// abort movement if the soldier has LOS on building
if(_canShoot)then{[_man] call SFSM_fnc_abortForcedMove;};

false;