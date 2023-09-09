params["_man"];
_man enableAI "anim";
_man setAnimSpeedCoef 1;
_man doMove getPosATLVisual _man;
_man setDir (_man getDir _pos);
_man setVariable ["SFSM_SprintDestination", nil];
_man setVariable ["SFSM_SprintAnimUpdates", nil];
_man setVariable ["SFSM_Sprinting",         false];


if([_man, "abortSprint"] call SFSM_fnc_unitData)then{
    [_man, "abortSprint", false] call SFSM_fnc_unitData
};

true;