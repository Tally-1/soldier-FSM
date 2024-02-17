params[
    ["_man",    nil, [objNull]],
    ["_target", nil, [objNull]]
];

private _able = [_man, _target] call SFSM_fnc_canDoEvasiveAttack;
if(_able isEqualTo false)exitWith{};

private _anims     = [_man, _target] call SFSM_fnc_evasiveAttackAnims;
if(_anims isEqualTo [])exitWith{
	[_man, "No Evasive attackpath found", 0.5] spawn SFSM_fnc_flashAction;
};


private _condition = {[_man] call  SFSM_fnc_evasiveAttackCondition;};
private _midFnc    = {[_man] call SFSM_fnc_evasiveAttackMidFnc;};
private _endFnc    = {[_man] spawn SFSM_fnc_endevasiveAttack;};


[_man, "Evasive attack", 2]                       spawn SFSM_fnc_flashAction;
[_man, _target]                                   call  SFSM_fnc_initevasiveAttack;
[_man, _target]                                   spawn SFSM_fnc_evasiveAttackLoop;
[_man, _anims, true, _condition,_midFnc, _endFnc] call  SFSM_fnc_playAnimList;


true;