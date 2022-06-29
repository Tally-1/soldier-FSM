params["_hnkObjects", "_hunkerObjData"];
private _object = "";
{
	if([_x, _hunkerObjData] call SFSM_fnc_hunkAvailable)
	exitWith{_object = _x};

} forEach _hnkObjects;

if(_object == "")exitWith{};

_object