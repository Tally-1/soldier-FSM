params["_man"];
private _firePos = _man getVariable "SFSM_myFirePos";
if(!isNil "_firePos")then{[_firePos] call SFSM_fnc_dbgTxtFirePos;};

true;