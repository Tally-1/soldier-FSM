[] call SFSM_fnc_allAiRescueCapture;
[] call SFSM_fnc_handleHijackGlobal;
{[_x, false] call SFSM_fnc_groupLeaveTurrets;} forEach allGroups;