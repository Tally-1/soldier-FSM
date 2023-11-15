params ["_man"];
_man playMoveNow "Acts_executionvictim_Loop";
_man setVariable ["SFSM_captive", true];
[_man, "Captured"] call SFSM_fnc_setAction;

true;