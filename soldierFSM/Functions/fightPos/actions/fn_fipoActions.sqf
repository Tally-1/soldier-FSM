params["_man"];
if([_man] call SFSM_fnc_getOutAzFipo)        exitWith{};
if([_man] call SFSM_fnc_fipoLeaderAway)      exitWith{};
if([_man] call SFSM_fnc_curatorGetOutFipo)   exitWith{};
if([_man] call SFSM_fnc_leaderGetOutFipo)    exitWith{};
if([_man] call SFSM_fnc_safeGetOutFipo)      exitWith{};
if([_man] call SFSM_fnc_fipoCorrectPosition) exitWith{};
if([_man] call SFSM_fnc_initOverRun)         exitWith{};
if([_man] call SFSM_fnc_fipoOutFlanked)      exitWith{};
if([_man] call SFSM_fnc_getOutFipoHitAndRun) exitWith{};
if([_man] call SFSM_fnc_getOutDynamicFipo)   exitWith{};
if([_man] call SFSM_fnc_fipoPanic)           exitWith{};
if([_man] call SFSM_fnc_initFipoPeek)        exitWith{};
if([_man] call SFSM_fnc_initIdleFipoMove)    exitWith{};
if([_man] call SFSM_fnc_fipoRemoveUseless)   exitWith{};

true;