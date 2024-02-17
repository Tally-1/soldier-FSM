params["_man"];
private _validSide  = (side _man) in [west, east, independent];
if(_validSide isEqualTo false)exitWith{false;};

private _functional = [_man, true, true, true, true] call SFSM_fnc_canRun;

_functional;