params["_man"];
private _leader = leader group _man;

[_man] call SFSM_fnc_getOutFipo;
[_man] spawn SFSM_fnc_regroup;



true;