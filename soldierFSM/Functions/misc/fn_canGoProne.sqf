params["_man"];
private _suppression    = (getSuppression _man);
private _proneTreshHold = [_man] call SFSM_fnc_getProneTreshHold;

if(_suppression < _proneTreshHold)            exitWith{false;};
if([_man] call SFSM_fnc_inFipo)               exitWith{true;};
if("CQB" in ([_man] call SFSM_fnc_getAction)) exitWith{false;};
if(insideBuilding _man > 0.5)                 exitWith{false;};

true;