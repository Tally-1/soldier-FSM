params ["_man"];
private _side = side _man;
private _fipo = [_man] call SFSM_fnc_getFipo;
if(isNil "_fipo")exitWith{false;};

private _azFipo = _fipo getVariable "azFipoData";
if(isNil "_azFipo")exitWith{false;};
_azFipo set ["owner", _man];
private _leaving = _azFipo call ["getOut"];

// Bool to indicate wether or not the man is leaving the FIPO
_leaving;