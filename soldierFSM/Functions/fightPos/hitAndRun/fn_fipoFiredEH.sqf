params ["_man"];

private _eh =
_man addEventHandler ["Fired", {
    params ["_man"];
	if!([_man, true] call SFSM_fnc_inFipo)exitWith{};

	private _fipo = [_man] call SFSM_fnc_getFipo;
	if!(_fipo getVariable "hitAndRun")exitWith{};

	private _firstShot = _fipo getVariable "SFSM_firstShot";
	if(!isNil "_firstShot")exitWith{};
	
	_fipo setVariable ["SFSM_firstShot", time];

}];

_man setVariable ["SFSM_fipoFiredEh", _eh];

true;