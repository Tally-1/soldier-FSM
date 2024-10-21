// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3
// 
// Example:
// [_man, (getPosATLVisual player)] spawn SFSM_fnc_forceMove2;

params [
    "_man",                  // the man that will move.
    "_targetPos",           //  target position
    ["_maxTime", 30],      //   timeout (max time to attempt to reach said pos)
    ["_maxDistance", 1.1],//    distance to wanted pos before aborting move.
    ["_spamTimer", 1.5], //     seconds between each repetition of the doMove command.
    "_postFnc"          //      function to be run on completion [[params], _isScheduled, _code]
];

[_man] call SFSM_fnc_fixPos;

if([_man, _targetPos] call SFSM_fnc_canSprint)exitWith{
    
    [_man, _targetPos] call SFSM_fnc_sprint;
    
    if([_man, "abortForcedMove"] call SFSM_fnc_unitData)exitWith{
       [_man, "abortForcedMove", false] call SFSM_fnc_unitData;
       _this call SFSM_fnc_postForceMove2;
    if([_man, "abortSprint"] call SFSM_fnc_unitData)exitWith{
       [_man, "abortSprint", false] call SFSM_fnc_unitData;
       _this call SFSM_fnc_postForceMove2;
    };
    };
    
    _this call SFSM_fnc_forceMoveToPos2;
    _this call SFSM_fnc_postForceMove2;

};

[_man, "Calculating path"] spawn SFSM_fnc_flashAction;
[_man, _targetPos, 3.2]    call  SFSM_fnc_calculatePath;

private _path = _man getVariable "SFSM_currentPath";
if(isNil "_path")exitWith{
    _this call SFSM_fnc_forceMoveToPos2;
    _this call SFSM_fnc_postForceMove2;
};

[_man, "Path calculated"] spawn SFSM_fnc_flashAction;

private _startPos     = getPosATLVisual _man;
private _startTime    = time;
private _posTimeLimit = _maxTime / (count _path);
{
    if([_man, "abortForcedMove"] call SFSM_fnc_unitData) exitWith{};
    if([_man, "inFipo"] call SFSM_fnc_unitData)          exitWith{};
    [_man, _startPos, _startTime] call SFSM_fnc_forcedMoveProne;

    // _man doFollow _man;
    [
        _man,
        _x,
        _posTimeLimit,
        1,
        _spamTimer
    ]
    call SFSM_fnc_forceMoveToPos2;

    [_man, "forcedMovement", true] call SFSM_fnc_unitData;

} forEach _path;

private _completeFail = [
        _man,
        _startTime,
        _maxTime,
        _startPos,
        _targetPos

    ] call SFSM_fnc_forcedMoveHasFailed;

if(_completeFail)then{[_man, _startPos, _targetPos] call SFSM_fnc_onForcedMoveFailed;};

[_man] call SFSM_fnc_fixPos;
_man doFollow (leader group _man);
_man getVariable "SFSM_UnitData"set["hasForcedMoveProned", true];


// Forced unscheduled execution
// https://community.bistudio.com/wiki/call
isNil {_this call SFSM_fnc_postForceMove2;};

true;