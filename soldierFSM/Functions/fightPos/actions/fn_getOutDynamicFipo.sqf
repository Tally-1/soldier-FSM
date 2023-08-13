params["_man"];
private _fipo = [_man] call SFSM_fnc_getFipo;

if(isNil "_fipo")exitWith{
	// _man switchMove "AmovPercMstpSrasWrflDnon";
	// [_man] call SFSM_fnc_getOutFipo;
	// true;
};

if(_fipo getVariable "dynamicFipo" isEqualTo false) exitWith{false;};

private _active = [_fipo, _man] call SFSM_fnc_dynamicFipoActive;
if(_active isEqualTo true)exitWith{
	_fipo setVariable ["active", true];
	false;
};

_fipo setVariable ["active", false];

_man switchMove "AmovPercMstpSrasWrflDnon";
[_man] call SFSM_fnc_getOutFipo;

true;