params[
    ["_man",    nil, [objNull]]
];
private _target = _man getVariable "SFSM_myAttackTarget";

[_man] spawn SFSM_fnc_evasiveAttackAlign;
[_man, _target, 3] call SFSM_fnc_ifAimThenFire;

_man doFire _target;

true;