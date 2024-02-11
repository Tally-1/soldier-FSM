params[
	["_group", nil, [grpNull]]
];
private _client  = clientOwner;
private _owner   = groupOwner _group;
private _foreign = !(_owner in [0,_client]);

if(_foreign)then{
	if([] call SFSM_fnc_isHeadLess)
	then{[_group, _client] remoteExecCall ["setGroupOwner", 2]; sleep 0.5;}
	else{_group setGroupOwner _client};
	private _msg = ["GroupOwner changed from ", _owner, " to ", _client]joinString"";
	[_msg] remoteExecCall ["SFSM_fnc_debugMessage", 0];
};

private _data = _group getVariable "SFSM_groupData";
if(isNil "_data")
then{[_group] call SFSM_fnc_initGroup;};

private _units = units _group;

{
	if([_x,true] call SFSM_fnc_isRealMan)
	then{[_x] call SFSM_fnc_initMan;};

} forEach _units;

true;