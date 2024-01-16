params[
    ["_man",    nil, [objNull]],
    ["_target", nil, [objNull]]
];

private _able     = [_man, _target] call SFSM_fnc_canDoEvasiveAttack;
private _startPos = getPosATLVisual _man;
if(_able isEqualTo false)exitWith{};



private _condition = { [_man] call SFSM_fnc_evasiveAttackCondition};
private _midFnc    = {[_man] spawn SFSM_fnc_evasiveAttackAlign;};
private _endFnc    = {[_man] spawn SFSM_fnc_endevasiveAttack;};
private _anims     = [_man, _target] call SFSM_fnc_evasiveAttackAnims;

[_man, "Evasive attack"]                          spawn SFSM_fnc_flashAction;
[_man, _target]                                   call  SFSM_fnc_initevasiveAttack;
[_man, _anims, true, _condition,_midFnc, _endFnc] call  SFSM_fnc_playAnimList;
[_man, _target]                                   call  SFSM_fnc_evasiveAttackLoop;

true;