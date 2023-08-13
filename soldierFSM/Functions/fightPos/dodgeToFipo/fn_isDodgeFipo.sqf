params["_man", "_fipo"];

// fipo is outside dodgeDistance
if(_fipo distance2D _man >= SFSM_DodgeDistance)      exitWith{false;};

//if fipo is taken
private _available = (count(synchronizedObjects _fipo select {_x isNotEqualTo _man})) < 1;
_available = [_fipo, _available] call SFSM_fnc_fipoAvailable;
if(_available isEqualTo false)                       exitWith{false;};

//if this fipo is not allowed for this man
if!([_man, _fipo] call SFSM_fnc_fipoAllowedMan)      exitWith{false;};

true;