// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: determines if a group is excluded from dodging

// Params: _group: group to check
 
// Return value: true if group is excluded from dodging, false otherwise

// Example: [_group] call SFSM_fnc_groupCanDodge;


params["_group"];

if(isNil "_group") exitWith{false};
if(isNull  _group) exitWith{false};

private _grpDodgeDisabeled = [_group, 'dodgeDisabeled'] call SFSM_fnc_groupData;

if(!isNIl "_grpDodgeDisabeled" 
&&{_grpDodgeDisabeled})
exitWith{"zeus blocked dodge" call dbgmsg; false}; 

private _leader = (leader _group);

private _playerLead = [_leader] call Tcore_fnc_isPlayer;

if(_playerLead && {(! SFSM_PlayerGrpDodge)})
exitWith{
            "player-lead group, cannot dodge" call dbgmsg; 
            false
        }; 

true; 