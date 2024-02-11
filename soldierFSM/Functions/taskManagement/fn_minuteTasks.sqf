[] call SFSM_fnc_allAiRescueCapture;
[] call SFSM_fnc_handleHijackGlobal;
[] call SFSM_fnc_initNewGroups;
{[_x, false] call SFSM_fnc_groupLeaveTurrets;} forEach allGroups;