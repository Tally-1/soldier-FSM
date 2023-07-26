params["_man"];

private _z = _man Getvariable ["bis_fnc_moduleRemoteControl_owner", ""];
if(_z isEqualTo "")exitwith{false};

_man switchMove "AmovPercMstpSrasWrflDnon";

[_man] call SFSM_fnc_getOutFipo;

true;