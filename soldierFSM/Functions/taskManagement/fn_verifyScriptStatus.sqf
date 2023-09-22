private _active = (diag_activeSQFScripts select {"SFSM_fnc_" in (_x#0)})apply {_x#0};
private _wanted = [
  "SFSM_fnc_TaskManager",
  "SFSM_fnc_fipoManager",
  "SFSM_fnc_AZmanager",
  "SFSM_fnc_fipoFSM"
];

{
	if!(_x in _active)then{
		private _msg = [_x, " HAS FAILED. Send a message to Tally and let him know"] joinString "";
		hint _msg;
		diag_log _msg;
		[_msg, 2] call dbgmsg;

	};
	
} forEach _wanted;

true;