params["_man", "_victim"];
if!([_man, _victim] call SFSM_fnc_canRescue)exitWith{
    [_man, _victim, true] call SFSM_fnc_failRescue;
};

private _rescue = [_victim] spawn SFSM_fnc_calmPanicked;
waitUntil{sleep 0.5; scriptDone _rescue; };
[_man,  "none"] call SFSM_fnc_setAction;
[_man,  "Rescue completed"] spawn SFSM_fnc_flashAction;