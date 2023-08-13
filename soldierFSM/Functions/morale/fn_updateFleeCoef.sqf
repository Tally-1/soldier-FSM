params["_man"];
private _morale   = [_man, "morale"] call SFSM_fnc_unitData;
private _fleeCoef = 1 - _morale;
private _courage  = 1 - (_man skill "courage");

if(_fleeCoef < 0)   then{_fleeCoef = 0;   };

private _fleeCoefFinal = (_courage * _fleeCoef);

_man allowFleeing _fleeCoefFinal;

// [_man, (str _fleeCoefFinal)] spawn SFSM_fnc_flashAction;

_fleeCoefFinal;