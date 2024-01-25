params[ 
	["_man", nil, [objNull]]
];
if!([_man, true] call SFSM_fnc_canReturnToFormation)exitWith{};

[_man, "Moving to squad-leader"] call SFSM_fnc_setAction;

Private _onFinish = {
    private _man = _this#0;
    [_man, "Ended return to formation"] spawn SFSM_fnc_flashAction;
	[_man, "none"] call SFSM_fnc_setAction;
	_man doFollow leader group _man;
    true;
};

private _timeLimit  = 30;
private _targetPos  = getPosATL leader group _man;
private _postAction = [[_man], false, _onFinish];

[
    _man, 
    _targetPos,
    _timeLimit,
    2,
    2,
    _postAction
] spawn SFSM_fnc_forceMove2;

true;