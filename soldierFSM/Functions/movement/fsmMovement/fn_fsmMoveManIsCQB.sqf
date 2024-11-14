params [ 
    ["_man",nil,[objNull]] // The man that will move.
];
private _prevVal   = _man getVariable "FSM_CQB";
private _lastCheck = _man getVariable ["FSM_lastCqbCheck",time-1];
private _time      = time - _lastCheck;
if(_time<1)exitWith{_prevVal};

private _isIndoors = !isNil{[_man] call SFSM_fnc_currentBuilding};
if(_isIndoors)exitWith{
	_man setVariable ["FSM_CQB",          true];
	_man setVariable ["FSM_lastCqbCheck", time];
	true;
};

private _enemies = [_man] call SFSM_fnc_nearEnemies;
if(_enemies isEqualTo [])exitWith{
	_man setVariable ["FSM_CQB",          false];
	_man setVariable ["FSM_lastCqbCheck",  time];
	false;
};

if(_time<2)exitWith{_prevVal};

_enemies = _enemies select {[_man, _x] call SFSM_fnc_targetVisible};
if(_enemies isEqualTo [])exitWith{
	_man setVariable ["FSM_CQB",          false];
	_man setVariable ["FSM_lastCqbCheck",  time];
	false;
};

_man setVariable ["FSM_CQB",true];
true;