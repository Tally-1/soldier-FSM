params[
    "_man", 
    "_target",
    ["_moveType", selectRandom ["zig-zag", "flank right", "flank left"]]
];

private _able = [_man, _target] call SFSM_fnc_canDoEvasiveAttack;
if(_able isEqualTo false)exitWith{};

private _condition = { [_man] call SFSM_fnc_evasiveAttackCondition};
private _midFnc    = { [_man] spawn SFSM_fnc_evasiveAttackAlign};
private _endFnc    = { [_man] spawn SFSM_fnc_endevasiveAttack;};
private _anims     = [_moveType] call SFSM_fnc_evasiveAttackAnims;

[_man, _moveType]                                  spawn SFSM_fnc_flashAction;
[_man, _target]                                    call  SFSM_fnc_initevasiveAttack;
[_man, _anims, true, _condition,_midFnc, _endFnc]  call  SFSM_fnc_playAnimList;
[_man, _target]                                    call  SFSM_fnc_evasiveAttackLoop;

true;