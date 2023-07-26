params["_man", "_fipo"];
[["Man is leaving a hit and run position"],2] call dbgmsg;
[_man, "Hit... now RUN!"] call SFSM_fnc_setAction;
[_man, "Leaving hit and run pos", 0.3] call SFSM_fnc_flashAction;

private _group   = group _man;
private _canMove = [_man, true] call SFSM_fnc_canRun;
private _nearFipos = ([_group] call SFSM_fnc_nearGroupFiposs);

if(_nearFipos isNotEqualTo [])exitWith{
    private _newFipo  = [_man, _nearFipos] call SFSM_fnc_getNearest;
	private _canGetIn = _canMove && {[_newFipo] call SFSM_fnc_fipoAvailable};
	[_man, _newFipo, _canGetIn] spawn SFSM_fnc_moveInFipo;
	[_man, "Moving in to next Fipo"] call SFSM_fnc_flashAction;

};

private _backDir = [((getDir _fipo)-180)] call Tcore_fnc_formatDir;
private _srchPos = _man getPos [(SFSM_DodgeDistance-30), _backDir];
private _avail   = [_srchPos, 30, 10] call Tcore_fnc_availablePositions;
private _newPos  = [_man, _avail] call SFSM_fnc_getNearest;

if(isNil "_newPos")exitWith{
	[_man, "none"] call SFSM_fnc_setAction;
	[_man, "Hit and run failed, NOWHERE TO RUN!"] call SFSM_fnc_flashAction;
};

private _endCode = {
	params["_man"];
	[_man, "none"] call SFSM_fnc_setAction;
	[_man, "Hit and run completed"] call SFSM_fnc_flashAction;
};
private _postFnc = [[_man], false, _endCode];

private _run = [_man, _newPos, 20, 10, 5, _postFnc] spawn SFSM_fnc_forceMove2;

// waitUntil{sleep 1; scriptDone _run;};



true;