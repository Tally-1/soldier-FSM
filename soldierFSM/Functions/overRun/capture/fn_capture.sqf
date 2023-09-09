params ["_man", "_captor"];

if([_man] call SFSM_fnc_isUncon)then{
    [_man, false] call ace_medical_fnc_setUnconscious;
    [_captor, _man] call ace_medical_treatment_fnc_fullHeal;
    // private _surrender = 
    [_man] call SFSM_fnc_surrender;
    // waitUntil{sleep 0.1; scriptDone _surrender};
};

[[name _man, " was captured by ", (name _captor)],1] call dbgmsg;

[_man]  remoteExecCall ["removeAllActions", 0];
[_man] call SFSM_fnc_executeAction;



_man playMoveNow "Acts_ExecutionVictim_Loop";
_man setVariable ["SFSM_captive", true];
[_man, "Captured"] call SFSM_fnc_setAction;

_man addEventHandler ["Killed", { 
    params ["_man", "_killer", "_instigator", "_useEffects"];
    [_man, "Acts_ExecutionVictim_Kill_End"] remoteExecCall ["switchMove",0];
    [_man] remoteExecCall ["removeAllActions", 0];
    _man removeEventHandler [_thisEvent, _thisEventHandler];
}];

_man addEventHandler ["Hit", { 
    _this append [_thisEvent, _thisEventHandler];
    _this spawn {
    sleep 0.02;
    params ["_man", "_killer", "_instigator", "_useEffects", "_thisEvent", "_thisEventHandler"];
    if([_man] call SFSM_fnc_isUncon)then{
    _man setDamage 1;
    _man removeEventHandler [_thisEvent, _thisEventHandler]; 
}}}];


if(random 1 < SFSM_bombOnCapture)exitWith{
    createVehicle ["Bomb_03_F", (GetPosATL _man)];
    private _text = [name _man, " blew himself and ", (name _captor), " into very small pieces"]joinString"";
    [_text] call dbgmsg;
};

["capture",  [_man, _captor]] call CBA_fnc_localEvent;

_man spawn {
    sleep 3;
    if(animationState _this isNotEqualTo "acts_executionvictim_loop")then{
        _this playMoveNow "Acts_ExecutionVictim_Loop";
        [_this, "Captured"] call SFSM_fnc_setAction;
    };
    sleep 300; 
    _this setDamage 1;
};
