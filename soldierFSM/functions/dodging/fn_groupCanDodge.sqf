params["_group"];

if(!isNil "_group")exitWith{false};
if(isNull  _group) exitWith{false};

private _grpDodgeDisabeled = [_group, 'dodgeDisabeled'] call SFSM_fnc_groupData;
if(_grpDodgeDisabeled)exitWith{"zeus blocked dodge" call dbgmsg;false};

private _leader = (leader _group);

private _playerLead = [_leader] call Tcore_fnc_isPlayer;

if(_playerLead && {(! SFSM_PlayerGrpDodge)})
exitWith{
			"player-lead group, cannot dodge" call dbgmsg; 
			false
		};

true; 