params["_man"];

[_man] call SFSM_fnc_adjustSprintDir;
[_man] call SFSM_fnc_updateSprintAnims;
[_man] call SFSM_fnc_updateSprintTimer;
[_man] call SFSM_fnc_sprintSuppress;

true;