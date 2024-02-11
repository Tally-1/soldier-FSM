params[
    ["_man",       nil, [objNull]],
    ["_unitPos",   nil,      [""]],
    ["_stepRight", nil,    [true]]
]; 

private _anim     = [_unitPos, _stepRight] call SFSM_fnc_getSideStepAnim;
private _idleAnim = _man getVariable "SFSM_idleAnim";

if!(isNil "_idleAnim")
then{[_man] call SFSM_fnc_abortIdleFipo;};

[_man, "fipo-sidestep", true] call SFSM_fnc_unitData;
[_man, "Peeking sidestep"]    call SFSM_fnc_setAction;
[_man, _anim]                 call SFSM_fnc_execSideStep;

true;