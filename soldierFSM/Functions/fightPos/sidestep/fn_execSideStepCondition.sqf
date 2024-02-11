params[
    ["_man", nil, [objNull]]
];
private _fipo = [_man] call SFSM_fnc_getFipo;
if(isNil "_fipo")exitWith {false;};

if((_man getVariable ["SFSM_returnStep",  false]) isEqualTo false)
exitWith{
	private _canContinue = [_man] call SFSM_fnc_canContinueSideStep;
	_canContinue;
};

private _canReturn = [_man] call SFSM_fnc_canReturnStep;

_canReturn;