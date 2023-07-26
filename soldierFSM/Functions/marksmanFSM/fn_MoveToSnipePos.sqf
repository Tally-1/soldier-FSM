params ["_marksman", "_target", "_firePos"];

_marksman setVariable ["SFSM_marksmanAction", "Moving to fire position", true];
_move = [_marksman, _firePos, 90] spawn SFSM_fnc_forceMove2;

waitUntil {
    private _abortMove = [_marksman, _target] call SFSM_fnc_abortMoveToSnipePos;
    if(_abortMove)then{[_marksman, "abortForcedMove", true] call SFSM_fnc_unitData;};
    
    _marksman setBehaviour "AWARE";
    _marksman setCombatBehaviour "AWARE";
    _marksman setUnitCombatMode "WHITE";
    sleep 0.3; 
    scriptDone _move; 
};

_move;