params["_man"];
[_man, "none"] call SFSM_fnc_setAction;
[_man, "Failed to move into position", 0.5] spawn SFSM_fnc_flashAction;

private _fipo = [_man] call SFSM_fnc_getFipo;
if(isNil "_fipo")exitWith{};

//Some data used to limit attempt spamming
[_man, "lastFipoAttempt", time] call SFSM_fnc_unitData;

private _attemptsFipo = _fipo getVariable ["getInAttempts", []];
_attemptsFipo pushBackUnique time;
_fipo setVariable ["getInAttempts", _attemptsFipo];

_man synchronizeObjectsRemove [_fipo];
_man doFollow (leader group _man);

[_man, 1.2] spawn SFSM_fnc_regroup;

true;