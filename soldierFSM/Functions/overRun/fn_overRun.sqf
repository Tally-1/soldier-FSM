params["_man", "_enemies"];
[_man] call SFSM_fnc_getOutFipo;
[_man, "lastOverRun", time] call SFSM_fnc_unitData;
["overrun",  [_man, _enemies]] call CBA_fnc_localEvent;

private _grp        = group _man;
private _allies     = [_man] call SFSM_fnc_overRunAllies;
private _actionType = [_man, _enemies, _allies] call SFSM_fnc_overRunDecision;

if(_actionType isEqualTo "panic")     exitWith{[_man] spawn SFSM_fnc_panic};
if(_actionType isEqualTo "surrender") exitWith{[_man] spawn SFSM_fnc_surrender};
if(_actionType isEqualTo "flee")      exitWith{[_man, _enemies] spawn SFSM_fnc_flee};

[_man, _enemies] spawn SFSM_fnc_overRunFight;