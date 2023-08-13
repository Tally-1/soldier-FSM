params["_group"];
"Group is fleeing" call dbgmsg;
private _units   = units _group select {[_x, true, true] call SFSM_fnc_canRun};
if(count _units isEqualTo 0)exitWith{
    "No members left in squad, cannot flee." call dbgmsg;
    false;
};

private _enemies = [(_units#0), 500] call SFSM_fnc_nearEnemies;

if(count _enemies isEqualTo 0)exitWith{
    "cannot flee, no enemies" call dbgmsg;
    false;
};


private _decision = [_x] call SFSM_fnc_squadFleeDecision;
if(_decision isEqualTo "fleeing, no SFSM input.")exitWith{
    "Group is fleeing but no added effect from SFSM" call dbgmsg;
    false;
};

[["Group ", _decision]] call dbgmsg;
_group setVariable ["SFSM_fled", true];

{
    
    if(_decision isEqualTo "surrender") then{[_x] spawn SFSM_fnc_surrender;};
    if(_decision isEqualTo "panic")     then{[_x] spawn SFSM_fnc_panic;};
    if(_decision isEqualTo "flee")      then{[_x] spawn SFSM_fnc_flee;};

} forEach _units;

true;