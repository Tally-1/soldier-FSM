params["_man"];
if!([_man] call SFSM_fnc_canSelfHeal)  exitWith{false;};
if!([_man] call SFSM_fnc_IsMedic)      exitWith{false;};
if!([_man, true] call SFSM_fnc_inFipo) exitWith{false;};

true;