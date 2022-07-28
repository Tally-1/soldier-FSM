params["_group"];

if(isNil "_group") exitWith{"Nil group" call dbgmsg; false};
if(isNull  _group) exitWith{"Null group" call dbgmsg; false};

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