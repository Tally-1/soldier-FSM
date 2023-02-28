params["_man"];
//remove eventHandler
private _eh = _man getVariable "SFSM_SprintEh";
_man removeEventHandler ["AnimDone", _eh];

//delete all variables defined in SFSM_fnc_sprintInit
_man setVariable ["SFSM_SprintEh",           nil];
_man setVariable ["SFSM_maxSegments",        nil];
_man setVariable ["SFSM_SprintTimer",        nil];
_man setVariable ["SFSM_SprintDestination",  nil];
_man setVariable ["SFSM_SprintSegmentsDone", nil];
_man setVariable ["SFSM_Sprinting",          nil];

//declare variable used in the wait condition in SFSM_fnc_sprint
_man setVariable ["SFSM_SprintComplete",     true];

//remove man from list of sprinters (used to cap the amount of simultaneous sprinters)
SFSM_sprinters deleteAt (SFSM_sprinters find _man);

//bohemia says it is good to have true at the end even if you do not need it.
true;