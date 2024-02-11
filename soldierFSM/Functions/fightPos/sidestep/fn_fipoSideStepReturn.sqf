params[
    ["_man",       nil, [objNull]],
    ["_unitPos",   nil,      [""]],
    ["_stepRight", nil,    [true]]
];
private _anim = [_unitPos, _stepRight] call SFSM_fnc_getSideStepAnim;

[_man, "Return sidestep"] call SFSM_fnc_setAction;
[_man, _anim, true]       call SFSM_fnc_execSideStep;


true;