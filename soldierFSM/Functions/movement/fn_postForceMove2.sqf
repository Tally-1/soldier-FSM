params [
    "_man",            // the man that will move.
    "_pos",           //  target position
    "_maxTime",      //   timeout (max time to attempt to reach said pos)
    "_maxDistance", //    distance to wanted pos before aborting move.
    "_spamTimer",  //     how often the doMove command is repeated.
    "_postFnc"    //      function to be run on completion [[params], _isScheduled, _code]
];


if([_man, "abortForcedMove"] call SFSM_fnc_unitData)then
{[_man, "abortForcedMove", false] call SFSM_fnc_unitData;};

_man doFollow (leader group _man);
_man setVariable ["SFSM_currentPath", nil, true]; 
[_man, "forcedMovement", false] call SFSM_fnc_unitData;
[_man] call SFSM_fnc_fixPos;
_man getVariable "SFSM_UnitData"set["hasForcedMoveProned", true];

if(isNil "_postFnc")exitWith{};

_postFnc call SFSM_fnc_execFromArr;

true;