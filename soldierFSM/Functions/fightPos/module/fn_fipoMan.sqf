params["_fipo"];
private _men = synchronizedObjects _fipo select {[_x] call SFSM_fnc_isRealMan;};
if(_men isEqualTo [])exitWith{};
private _man = _men#0;
_man;