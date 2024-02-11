params[
    ["_man", nil, [objNull]]
];

private _anim = SFSM_stanceToAnimMap get (stance _man);

[_man, _anim] remoteExecCall ["switchMove", _man];
[_man, "Anim stopped", 0.5] spawn SFSM_fnc_flashAction;

true;