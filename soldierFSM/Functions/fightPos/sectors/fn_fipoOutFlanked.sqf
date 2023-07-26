params["_fipoMan"];
private _fipo = [_fipoMan] call SFSM_fnc_getFipo;
if(isNil "_fipo") exitWith{false;};

private _rightFlankActive = _fipo getVariable "rightFlank";
private _leftFlankActive  = _fipo getVariable "leftFlank";
if(_rightFlankActive isEqualTo false
&&{_leftFlankActive  isEqualTo false})exitWith{false;};

private _fipoEnemies  = [_fipo] call SFSM_fnc_fipoFlankEnemies;
if(_fipoEnemies isEqualTo [[],[]])exitWith{false;};

if(SFSM_debugger)then{
	[_fipo] call SFSM_fnc_showActiveFlanks;
};
[_fipoMan, "Outflanked", 1.5] spawn SFSM_fnc_flashAction;
"Fighting position was outFlanked" call dbgmsg;
[_fipoMan] call SFSM_fnc_getOutFipo;

true;