params["_object"];
if(isNil "_object")                             exitWith{false;};
if(isNull _object)                              exitWith{false;};
if(typeName _object != "OBJECT")                exitWith{false;};
if(_object getVariable ["SFSM_captive", false]) exitWith{false;};

private _deletionTime = _object getVariable "SFSM_deleteTime";
if(isNil "_deletionTime") exitWith{false;};
if(time < _deletionTime)  exitWith{false;};

true;