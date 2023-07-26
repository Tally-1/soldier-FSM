params["_man"];
private _fipo = [_man] call SFSM_fnc_getFipo;
if(isNil "_fipo")                                        exitWith{false;};
if!(_fipo getVariable "hitAndRun")                       exitWith{false;};
if!([_man, true, true, true] call SFSM_fnc_canRun)       exitWith{false;};

private _timeUntilExit = [_fipo] call SFSM_fnc_fipoTimeUntilExit;
if(_timeUntilExit isEqualTo -1) exitWith{false;};
if(_timeUntilExit > 0)          exitWith{false;};

[_man]        call SFSM_fnc_getOutFipo;
[_man, _fipo] spawn SFSM_fnc_fipoRun;

true;