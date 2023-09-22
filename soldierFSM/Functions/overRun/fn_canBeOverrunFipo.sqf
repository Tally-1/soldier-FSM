// This function assumes the soldier is in a FIPO.
params["_man", "_enemies"];
private _fipo        = [_man] call SFSM_fnc_getFipo;
private _maxDistance = [_fipo] call SFSM_fnc_fipoOverrunDist;
private _nearest     = [_man, _enemies] call SFSM_fnc_getNearest;
private _distance    = _nearest distance2D _man;
private _action      = [_man] call SFSM_fnc_getAction;
// private _lastOr      = [_man, "lastOverRun"] call SFSM_fnc_unitData;

// Nearest enemy is out of OR range
if(_distance > _maxDistance) 
exitWith {false;};

// Fipo unit is already peeking.
if(_action isEqualTo "Peeking")                 
exitWith{false;};

// Fipo unit is already engaging a target.
if(_action isEqualTo "Engaging target")         
exitWith{false;};

true;