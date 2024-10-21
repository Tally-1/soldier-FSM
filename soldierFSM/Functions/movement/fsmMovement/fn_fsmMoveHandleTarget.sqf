params [
    ["_man", nil, [objNull]]
];
private _target = getAttackTarget _man;
if(!alive _target)exitWith{};

private _valid = [_man, _target] call SFSM_fnc_validFsmMoveTarget;
if(_valid)exitWith{};

private _CQB = _man getVariable "FSM_CQB";
if(_CQB)exitWith{};

_man forgetTarget _target;
_man doWatch objNull;
_man doTarget objNull;

true;