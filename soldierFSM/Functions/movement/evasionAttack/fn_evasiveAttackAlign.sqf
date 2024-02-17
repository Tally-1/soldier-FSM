params[
	["_man", nil, [objNull]]
];
private _targetPos    = getPosATLVisual (_man getVariable "SFSM_myAttackTarget");
private _timeLimit    = 1;
private _frequency    = 0.25;
private _maxDeviation = 1.1;

if(isNil "_targetPos")exitWith{[_man, "failed to align target", 0.5] spawn SFSM_fnc_flashAction;};

[
	_man,
	_targetPos,
	_timeLimit,
	_frequency,
	_maxDeviation
] call SFSM_fnc_forceLookAtPos;

true;