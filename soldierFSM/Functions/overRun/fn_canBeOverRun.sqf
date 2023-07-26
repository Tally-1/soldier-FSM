params["_man", "_enemies"];
if(_enemies isEqualTo [])exitWith{false;};

private _inFipo = [_man, true]          call SFSM_fnc_inFipo;
private _fipo   = [_man]                call SFSM_fnc_getFipo;
private _lastOr = [_man, "lastOverRun"] call SFSM_fnc_unitData;
private _action = [_man]                call SFSM_fnc_getAction;
private _OvrActions = ["Fleeing  ", "Counter Attacking"];

//already overrun
// if(_action in _OvrActions)                      exitWith{false;};

// Not in fipo and not available
if(_inFipo isEqualTo false
&&{!([_man] call SFSM_fnc_availableAiSoldier)}) exitWith{false;};

// current fipo does not allow overrun
if(_inFipo
&&{!(_fipo getVariable "allowOverrun")})        exitWith{false;};

// Overrun less than 2 minutes ago.
if(time - _lastOr < 120)                         exitWith{false;};

// Fipo unit is already peeking.
if(_action isEqualTo "Peeking")                 exitWith{false;};

// Fipo unit is already engaging a target.
if(_action isEqualTo "Engaging target")         exitWith{false;};

true;