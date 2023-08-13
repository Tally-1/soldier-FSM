params["_man", "_fipo"];

_fipo setVariable ["shotsFired", 0];
_fipo setVariable ["getInTime",  time];

[_man] call SFSM_fnc_firedHitAndRunEH;

true;