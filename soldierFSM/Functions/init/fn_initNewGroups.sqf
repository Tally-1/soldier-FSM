private _count = (count SFSM_newGroups);
if(_count isEqualTo 0)exitWith{};



for "_i" from 0 to (_count-1) do
{
	private _group = SFSM_newGroups#0;
	[_group] spawn SFSM_fnc_handleNewGroup;

	SFSM_newGroups deleteAt 0;
};

private _msg = ["Handled ", _count, " new groups"]joinString"";
[_msg] remoteExecCall ["SFSM_fnc_debugMessage", 0];

true;