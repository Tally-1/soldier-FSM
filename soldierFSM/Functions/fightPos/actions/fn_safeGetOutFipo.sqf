params["_man"];
if(behaviour _man isNotEqualTo "SAFE")exitWith{false;};
_man switchMove "AmovPercMstpSrasWrflDnon";

[_man] call SFSM_fnc_getOutFipo;

true;