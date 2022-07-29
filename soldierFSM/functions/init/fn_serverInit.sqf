[] call SFSM_fnc_initSettings;
[] call SFSM_fnc_postConfig;

{[_x] call SFSM_fnc_InitMan} 	forEach allUnits;
{[_x] call SFSM_fnc_InitGroup} 	forEach allGroups;
{_x   call SFSM_fnc_curatorEH}  forEach allCurators;

[] spawn SFSM_fnc_TaskManager;
[] spawn SFSM_fnc_spottedCustomEH;
[] call  SFSM_fnc_unitKilled;



diag_log "***soldier FSM * server loaded***";




[] call SFSM_fnc_logSettings;