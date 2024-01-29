params [
    "_man",                  // the man that will move.
    "_targetPos",           //  target position
    ["_maxTime", 30],      //   timeout (max time to attempt to reach said pos)
    ["_maxDistance", 1.1],//    distance to wanted pos before aborting move.
    ["_spamTimer", 1.5], //     seconds between each repetition of the doMove command.
    "_postFnc"          //      function to be run on completion [[params], _isScheduled, _code]
];

if!([_man, _targetPos] call SFSM_fnc_canSprint)exitWith{false;};
    
[_man, _targetPos] call SFSM_fnc_sprint;
    
if([_man, "abortForcedMove"] call SFSM_fnc_unitData)exitWith{
    [_man, "abortForcedMove", false] call SFSM_fnc_unitData;

    _this call SFSM_fnc_postForceMove2;
    
	if([_man, "abortSprint"] call SFSM_fnc_unitData)exitWith{
       [_man, "abortSprint", false] call SFSM_fnc_unitData;
       _this call SFSM_fnc_postForceMove2;
	   true;
    };
    
	true;
};
    
_this call SFSM_fnc_forcedMoveToPos;
_this call SFSM_fnc_postForceMove2;

true;