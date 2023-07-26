params["_fipo"];
private _marker = _fipo getVariable "marker";
if(isNil "_marker")exitWith{};

private _fipoMan = [_fipo] call SFSM_fnc_fipoMan;
if(isNil "_fipoMan")exitWith{
	_marker setMarkerAlpha 0.4;
};

_marker setMarkerAlpha 1;