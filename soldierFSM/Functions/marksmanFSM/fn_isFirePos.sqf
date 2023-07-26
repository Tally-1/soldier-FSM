params ["_marksman", "_target", "_firePos"];
if(isNil "_firePos")exitWith{false;};

//if there are enemies close, then the position is invalid.
private _enemies = [_marksman, nil, _firePos] call SFSM_fnc_nearEnemies;
if(_enemies isNotEqualTo [])exitWith{false;};

private _targetPos = getPosASL _target;
        _targetPos = ATLToASL [_targetPos#0, _targetPos#1, 0.4];
private _startPos = ATLToASL [_firePos#0, _firePos#1, 0.3];

private _visibility = [_marksman, "VIEW", _target] checkVisibility [_startPos, _targetPos];
if (_visibility < 0.3) exitWith {false;};

true;