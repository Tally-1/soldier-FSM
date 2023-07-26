params["_man"];
if!(_man isEqualTo leader group _man)       exitWith{false;};
if!([group _man] call SFSM_fnc_hasActiveWp) exitWith{false;};

_man switchMove "AmovPercMstpSrasWrflDnon";

[_man] call SFSM_fnc_getOutFipo;

true;