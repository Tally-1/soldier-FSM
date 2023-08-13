params["_fipoMan"];

private _showFlanks  = "true";
[["Showing flanks"],2] call dbgmsg;

while {_showFlanks isEqualTo "true"} do {
	
	if!([_fipoMan, true] call SFSM_fnc_inFipo) exitWith{_showFlanks = "not in fipo";};
	
	private _fipo               = [_fipoMan] call SFSM_fnc_getFipo;
	private _rightFlankActive   = _fipo getVariable "rightFlank";
	private _leftFlankActive    = _fipo getVariable "leftFlank";
	private _selectedObjects    = curatorSelected#0;
	
	if(_rightFlankActive               isEqualTo false
	&&{_leftFlankActive                isEqualTo false
	&&{_fipo getVariable "dynamicFipo" isEqualTo false}}) exitWith{_showFlanks = "No flanks to show";};
	if(count _selectedObjects isNotEqualTo 1)             exitWith{_showFlanks = "Unselected fipo";};
	

	[_fipo, true] call SFSM_fnc_showActiveFlanks;
	sleep 0.2;
};

[[_showFlanks],2] call dbgmsg;

true;