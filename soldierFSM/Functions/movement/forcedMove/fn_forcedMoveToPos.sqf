params [
    ["_man",         nil, [objNull]],    // The man that will move.
    ["_pos",         nil,      [[]]],   //  Target position
    ["_maxTime",      30,       [0]],  //   Timeout (max time to attempt to reach said pos)
    ["_maxDistance", 1.3,       [0]], //    Distance 
    ["_postFnc", [[],{}],      [[]]] //     [[Params],{Code}] to execute on end.
];
private _canSprint  = [_man, _pos, 50, 5] call SFSM_fnc_canSprint;
private _combatMode = unitCombatMode _man;
_pos = [_pos] call SFSM_fnc_formatMovePos;

if(_canSprint)exitWith{
    [_man, _pos] call SFSM_fnc_sprint;
    
    if([_man, _pos] call SFSM_fnc_canSprint)exitWith{[_man, _pos] call SFSM_fnc_sprint;};
};
 
[_man]              call SFSM_fnc_initForcedMoveToPos;
[_man]              call SFSM_fnc_whileForcedMove;
[_man, _combatMode] call SFSM_fnc_endForcedMoveToPos;

private _distToPos  = [_man distance2D _pos, 2] call Tcore_fnc_decimals;
private _moveFailed = _distToPos > _maxDistance;

if(_moveFailed)exitWith{ 
    private _noFlash = SFSM_debugger && {(_man getVariable "SFSM_UnitData" get "flashAction") isEqualTo ""};
    private _txt     = ["Target-pos missed by ", _distToPos,"m"]joinString"";
    if(_noFlash)then{[_man, _txt] spawn SFSM_fnc_flashAction;};
    false;
};

if(_postFnc isNotEqualTo [[],{}])then{(_postFnc#0) call (_postFnc#1);};

true;