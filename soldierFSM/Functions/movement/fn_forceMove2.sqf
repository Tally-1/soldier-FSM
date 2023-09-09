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
    "_pos",                 //  target position
    ["_maxTime", 30],      //   timeout (max time to attempt to reach said pos)
    ["_maxDistance", 1.1],//    distance to wanted pos before aborting move.
    ["_spamTimer", 1.5], //     seconds between each repetition of the doMove command.
    "_postFnc"          //      function to be run on completion [[params], _isScheduled, _code]
];

// doStop _man;
[_man] call SFSM_fnc_fixPos;
_man doFollow _man;

if([_man, _pos] call SFSM_fnc_canSprint)exitWith{

    // private _sprint = 
    [_man, _pos] call SFSM_fnc_sprint;
    // waitUntil{sleep 0.3; scriptDone _sprint;};
    

    if([_man, "abortForcedMove"] call SFSM_fnc_unitData)exitWith{
       [_man, "abortForcedMove", false] call SFSM_fnc_unitData;
       _this call SFSM_fnc_postForceMove2;
    if([_man, "abortSprint"] call SFSM_fnc_unitData)exitWith{
       [_man, "abortSprint", false] call SFSM_fnc_unitData;
       _this call SFSM_fnc_postForceMove2;
    };
    };

    // private _move = 
    _this call SFSM_fnc_forceMoveToPos;
    // waitUntil { sleep 0.1; scriptDone _move; };
    _this call SFSM_fnc_postForceMove2;

};

private _timer     = time + 3.2;
private _calculate = [_man, _pos, 3] spawn SFSM_fnc_calculatePath;
[_man, "Calculating path"] spawn SFSM_fnc_flashAction;
waitUntil {(scriptDone _calculate) || (_timer < time); };

private _path = _man getVariable "SFSM_currentPath";
if(isNil "_path")exitWith{
    // private _move = 
    _this call SFSM_fnc_forceMoveToPos;
    // waitUntil { sleep 0.1; scriptDone _move; };
    _this call SFSM_fnc_postForceMove2;
};

[_man, "Path calculated"] spawn SFSM_fnc_flashAction;


private _posTimeLimit = _maxTime / (count _path);
{
    if([_man, "abortForcedMove"] call SFSM_fnc_unitData) exitWith{};
    if([_man, "inFipo"] call SFSM_fnc_unitData)          exitWith{};
    // doStop _man;
    _man doFollow _man;
    // private _move = 
    [
        _man,
        _x,
        _posTimeLimit,
        1,
        _spamTimer
    ]
    call SFSM_fnc_forceMoveToPos;

    // waitUntil { sleep 0.1; scriptDone _move; };

    [_man, "forcedMovement", true] call SFSM_fnc_unitData;

} forEach _path;

[_man] call SFSM_fnc_fixPos;
_man doFollow (leader group _man);

// Forced unscheduled execution
// https://community.bistudio.com/wiki/call
isNil {_this call SFSM_fnc_postForceMove2;};

true;