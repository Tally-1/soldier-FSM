params["_man", "_forced"];
if (_forced)                        exitWith{true;};
if ([_man] call SFSM_fnc_isPlayer)  exitWith{false;};
if ([_man] call SFSM_fnc_isUncon)   exitWith{false;};
if ([_man] call SFSM_fnc_inFipo)    exitWith{false;};
if!([_man] call SFSM_fnc_isRealMan) exitWith{false;};

true;