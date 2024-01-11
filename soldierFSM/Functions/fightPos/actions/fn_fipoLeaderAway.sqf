params["_man"];
private _leader      = leader group _man;
private _maxDistance = SFSM_fipoGetInDistance;
private _distance    = _man distance2D _leader;

if(_man isEqualTo _leader)   exitWith{false;};
if(_distance < _maxDistance) exitWith{false;};


_man switchMove "AmovPercMstpSrasWrflDnon";
[_man] call SFSM_fnc_getOutFipo;

true;