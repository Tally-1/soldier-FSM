params[
    ["_shooter",        nil, [objNull]],
    ["_targetBuilding", nil, [objNull]]
];
private _myBuilding  = [_man] call SFSM_fnc_currentBuilding;
private _wrongTarget = (!isNil "_myBuilding") &&{_myBuilding isEqualTo _targetBuilding;};
if(_wrongTarget)
exitWith{false;};

private _side       = side _shooter;
private _friendlies = ([_targetBuilding] call SFSM_fnc_unitsInBuilding) select {side _x isEqualTo _side;};
if(_friendlies isNotEqualTo [])
exitWith{false;};

[_man, "lastCqbRpgCheck", time] call SFSM_fnc_unitData;

true;