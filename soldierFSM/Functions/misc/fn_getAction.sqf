params["_man"];
private _action = [_man, "action"] call SFSM_fnc_unitData;
if(isNil "_action")exitWith{};

_action;