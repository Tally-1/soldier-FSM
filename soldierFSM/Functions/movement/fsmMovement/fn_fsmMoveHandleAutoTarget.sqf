params [
    ["_man", nil, [objNull]]
];
private _deactivationTime = _man getVariable ["FSM_disableAtTime", time-1];
if(time < _deactivationTime)exitWith{};

private _atActive = _man checkAIFeature "AUTOTARGET";
if!(_atActive)exitWith{};

_man disableAI "AUTOTARGET";
_man setVariable ["FSM_disableAtTime", time+3];

true;