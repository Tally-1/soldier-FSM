params["_man"];

private _maxAddedCoef = 0.5;
private _allyCount    = count ([_man] call SFSM_fnc_nearAllies);

if (isNil "_allyCount")    exitWith{0;};
if (_allyCount isEqualTo 0)exitWith{0;};


private _allyCoef = _allyCount/10;

if(_allyCoef > _maxAddedCoef)then{_allyCoef = _maxAddedCoef};

_allyCoef;