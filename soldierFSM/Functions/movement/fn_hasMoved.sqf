params["_man"];
private _moveRegistry = _man getVariable "SFSM_unitData" get "moveRegistry";
private _count        = count _moveRegistry;
private _last         = _moveRegistry#(_count-1);
private _secondLast   = _moveRegistry#(_count-2);
private _distanceReg  = (_last#1)distance(_secondLast#1);
private _distanceMan  = (_last#1)distance2d(_man);

if(_count       < 4) exitWith{true;};
if(_distanceReg > 2) exitWith{true;};
if(_distanceMan > 2) exitWith{true;};

false;