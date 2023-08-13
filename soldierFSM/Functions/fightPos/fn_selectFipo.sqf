params["_man", "_fiposs"];
private _available = _fiposs select {
   [_man, _x] call SFSM_fnc_canMoveInFipo
   &&{[_x] call SFSM_fnc_fipoAvailable;}
};
if(_available isEqualTo [])exitWith{};

private _leader     = leader group _man;
private _leaderDest = (expectedDestination _leader)#0;
private _fipo       = [_leaderDest, _available] call SFSM_fnc_getNearest;

_fipo;