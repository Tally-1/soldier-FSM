private _delay = 0;
params["_man", "_delay"];

sleep _delay;
private _leader = leader group _man;

if ([_man] call SFSM_fnc_isPlayer)exitWith {
    [_man, "none"] call SFSM_fnc_setAction;
};
if!([_man, true] call SFSM_fnc_canRun)exitWith{
    [_man, "none"] call SFSM_fnc_setAction;
    [_man, "Cannot move..."] spawn SFSM_fnc_flashAction;
};

if(_man isEqualTo _leader)exitWith{
    [_man, "none"] call SFSM_fnc_setAction;
    [_man, "Leader does not regroup"] spawn SFSM_fnc_flashAction;
};

_man doFollow _leader;

if(_man distance _leader < 40)exitWith{};

[_man, "Regrouping"] call SFSM_fnc_setAction;
private _move = [_man, _leader] spawn SFSM_fnc_moveToMan;
waitUntil{
    if(_man distance2D _leader < 20)then{[_man] call SFSM_fnc_abortForcedMove;};
    sleep 0.2; 
    scriptDone _move;
};

[_man, "none"] call SFSM_fnc_setAction;

_man spawn {
    sleep 3;
    if([_this] call SFSM_fnc_getAction isEqualTo "Regrouping")then{
        [_this, "none"] call SFSM_fnc_setAction;
    };
};
