params["_man"];
[_man, "abortForcedMove", true] call SFSM_fnc_unitData;
[_man, "abortSprint",     true] call SFSM_fnc_unitData;

_man spawn{
    sleep 1.5;
    if([_this, "abortForcedMove"] call SFSM_fnc_unitData)then{
       [_this, "abortForcedMove", false] call SFSM_fnc_unitData;
    };
    if([_this, "abortSprint"] call SFSM_fnc_unitData)then{
       [_this, "abortSprint", false] call SFSM_fnc_unitData;
    };
};
true;