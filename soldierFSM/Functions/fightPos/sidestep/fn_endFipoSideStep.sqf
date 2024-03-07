params[
    ["_man",         nil, [objNull]],
    ["_coverStance", nil,      [[]]]
];

//change to cover(low) stance.
[_man, _coverStance] call SFSM_fnc_animSetStance;

//wait for stance to complete.
private _animTimer     = time+1.2;
private _coolDownTimer = time + (3 + ceil(random 3));
private _fipo          = [_man] call SFSM_fnc_getFipo;
private _tooFar        = (!isNil "_fipo") && {_fipo distance _man > SFSM_FipoGetOutDistance};
private _getOut        = isNil "_fipo" || _tooFar;

if(_getOut)exitWith{
	_man setVariable ["SFSM_animStanceDone", true];
    [_man, "Sidestep return failed"] spawn SFSM_fnc_flashAction;
	[_man] call SFSM_fnc_getOutFipo;
};

_man attachTo [_fipo, [0,0,0]];
waitUntil{((_man getVariable ["SFSM_animStanceDone", false]) || (time > _animTimer))};
detach _man;

// Set action and cooldown.
[_man, "In cover"] call SFSM_fnc_setAction;
[_man, "peekCooldown", _coolDownTimer] call SFSM_fnc_unitData;

true;