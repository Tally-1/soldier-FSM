private _inPosOnly = false;
params["_man", "_inPosOnly"];
private _fiPos = [_man] call SFSM_fnc_getFipo;
if(isNil "_fiPos")exitWith{false;};

if(_inPosOnly
&&{_fipos distance2D _man > 1.2})exitWith{false;};

true;