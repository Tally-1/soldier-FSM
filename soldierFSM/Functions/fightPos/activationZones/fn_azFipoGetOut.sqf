private _man    = _self get "owner";
private _side   = side _man;
private _active = _self call ["isActive", [_side]];

if(_active isEqualTo true)exitWith{false};

[_man] call SFSM_fnc_moveOutFipo;

true;