private _offSet = [0,0,0];
private _time   = 0.02;
params["_man", "_time", "_offSet"];

private _fipo = [_man] call SFSM_fnc_getFipo;
if(isNil "_fipo")exitWith{};

_man attachTo [_fipo, _offSet];
sleep _time;
detach _man;