params["_man"];
if!([_man] call SFSM_fnc_isRealMan)exitWith{false;};

private _previousTime  = [_man, "lastMoraleEvent"] call SFSM_fnc_unitData;
if(time-_previousTime < 0.1)exitWith{false;};

true;