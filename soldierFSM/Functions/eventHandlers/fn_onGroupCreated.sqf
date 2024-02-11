params[
	["_group",  nil, [grpNull]],
	["_client", nil,       [2]]
];

_group setGroupOwner _client;

[_group] remoteExecCall ["SFSM_fnc_initGroup", _client];

["Group spawned in"] remoteExecCall ["SFSM_fnc_debugMessage", 0];

true;