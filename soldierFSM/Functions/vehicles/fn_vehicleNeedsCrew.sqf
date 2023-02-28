params["_vehicle"];
if(typeName _vehicle != "OBJECT")exitWith{};
private _gunner = gunner _vehicle;
private _driver = driver _vehicle;
private _targetedBy = _vehicle getVariable ["targetedBy", []];
if(count _targetedBy > 0)exitWith{"car targeted, cannot reinforce"call dbgmsg; false;};
if((alive _driver) && {(!alive _gunner)})exitWith{true;};
if((!alive _driver) && {(alive _gunner)})exitWith{true;};
false;