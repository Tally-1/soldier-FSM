private _forced = false;
params["_man", "_forced"];
if!([_man, _forced]call SFSM_fnc_canResetBrain)exitWith{
	private _msg = "Brain reset failed";
	[_man, _msg] spawn SFSM_fnc_flashAction;
};

private _group      = group _man;
private _side       = side _group;
private _isLeader   = leader _group isEqualTo _man;
private _newGroup   = createGroup _side;
private _abilities  = [_man] call SFSM_fnc_abilitiesInUse;
private _squadIndex = [_man] call SFSM_fnc_getSquadIndex;

[_man]                    call SFSM_fnc_deActivateMan;
[_man, _newGroup]         call SFSM_fnc_forceGroupJoin;

if(!isNull _group)then{
	[_man, _group, _squadIndex] call SFSM_fnc_forceGroupJoin;
}else{
	[_man, "Original group invalid"] spawn SFSM_fnc_flashAction;
};

[_man, _abilities] call SFSM_fnc_activateMan;

if([_man] call SFSM_fnc_isDeactivated)exitWith{
	private _msg = "Brain reset failed, man is now braindead!";
	[_man, _abilities] call SFSM_fnc_activateMan;
	[_man, _msg] spawn SFSM_fnc_flashAction;
	_msg call dbgmsg;
};

[_man, "Brain reset"] spawn SFSM_fnc_flashAction;


["brain_reset", [_man]] call CBA_fnc_localEvent;

deleteGroup _newGroup;

if(_isLeader)then{
	group _man selectLeader _man;
};

[_man] call SFSM_fnc_fixPos;

true;