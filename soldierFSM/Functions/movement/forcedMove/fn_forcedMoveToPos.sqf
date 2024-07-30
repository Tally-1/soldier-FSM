params [ 
    ["_man",       nil, [objNull]],      //The man that will move.
    ["_pos",       nil,      [[]]],     // Target position
    ["_time",      nil,       [0]],    //  Timeout (max time to attempt to reach said pos)
    ["_cRadius",   3,         [0]],   //   Completion radius (distance to wanted pos before move can be considered complete).
    ["_endCode",   nil,      [[]]],  //    Function to be run on completion [[params],{_code}]
    ["_condition", [],       [[]]], //     Boolean function, if it returns false the move will be aborted. [[params],{_code}]
    ["_cndFreq",   0.1,       [0]] //      How often the custom condition is checked
];
private _canSprint  = [_man, _pos, 50, 5] call SFSM_fnc_canSprint;
private _combatMode = unitCombatMode _man;
_pos = [_pos] call SFSM_fnc_formatMovePos;

if(_canSprint)exitWith{
    [_man, _pos] call SFSM_fnc_sprint;
    
    if([_man, _pos] call SFSM_fnc_canSprint)
    then{[_man, _pos] call SFSM_fnc_sprint};

    if(!isNil "_endCode")
    then{(_endCode#0)call(_endCode#1)};
};


private _alreadyMoving = (_man getVariable ["FSM_moveEnded", true])isEqualTo false;
if(_alreadyMoving)
exitWith{[_man, "Move failed, already moving"] spawn SFSM_fnc_flashAction};

private _canRun = [_man,true] call SFSM_fnc_canRun;
if!(_canRun)
exitWith{[_man, "Move failed, Cannot run"] spawn SFSM_fnc_flashAction};

_this set [5,[[_man,true], SFSM_fnc_canRun]];
_this set [6,1];

_this call SFSM_fnc_initFsmMoveMan;
_this call SFSM_fnc_execFsmMoveMan;
_this call SFSM_fnc_endFsmMoveMan;

private _distToPos  = [_man distance2D _pos, 2] call Tcore_fnc_decimals;
private _moveFailed = _distToPos > _maxDistance;

if(_moveFailed)exitWith{ 
    private _noFlash = SFSM_debugger && {(_man getVariable "SFSM_UnitData" get "flashAction") isEqualTo ""};
    private _txt     = ["Target-pos missed by ", _distToPos,"m"]joinString"";
    if(_noFlash)then{[_man, _txt] spawn SFSM_fnc_flashAction;};
    false;
};


true;