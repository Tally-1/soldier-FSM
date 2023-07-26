// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3


//This eventhandler is supposed to return an array in a waypoint-format [group, waypointIndex].
//it is however only returning the group.
params ["_curator", "_waypoint"];
private _wpCount = (count(waypoints _waypoint));

if(_wpCount <= 1)
then{
        private _group = _waypoint;
        private _arr   = (_group getVariable 'SFSM_ZeusWaypoints');
        {_arr deleteAt (_arr find _waypoint)} forEach _arr;
        {[_group, 'dodgeDisabeled', false] call SFSM_fnc_groupData};
        'Last waypoint deleted, group can now dodge' call SFSM_fnc_DebugMessage;
    };

true;