params["_vehicle", "_man"];
[_man, "action", "none"] call SFSM_fnc_unitData;
private _arr = (_vehicle getVariable "targetedBy");
(_vehicle getVariable "targetedBy") deleteAt (_arr find _man);
_man doMove (getPos _man);
_man doFollow (leader (group _man));

true;