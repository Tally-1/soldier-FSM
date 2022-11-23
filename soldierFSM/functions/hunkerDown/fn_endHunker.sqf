params ["_man", "_objectHash", "_reason"];

[_man, "action",         "none"] 	call SFSM_fnc_unitData;
[_man, "hunkObjectHash", []] call SFSM_fnc_unitData;
_man enableAI "PATH";
_man setUnitPos "AUTO";
_man doFollow leader(group _man);

if((!isNil "_objectHash")
&&{(typeName _objectHash == "HASHMAP")})
then{_objectHash set ["owner", "none"]};


[["Hunker FSM ended for: ", (name _man), " ", _reason]] call dbgmsg;