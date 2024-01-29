params["_man", "_fipo"];
isNil{//Forced unscheduled execution

[["Man is leaving a hit and run position"],2] call dbgmsg;
[_man, "Hit... now RUN!"] call SFSM_fnc_setAction;
[_man, "Leaving hit and run pos", 0.3] spawn SFSM_fnc_flashAction;

private _group     = group _man;
private _canMove   = [_man, true] call SFSM_fnc_canRun;

// Select near && available FIPOs that is allowed for this specific man
private _nearFipos =  ([_group] call SFSM_fnc_nearGroupFiposs) select 
					  {[_man, _x] call SFSM_fnc_fipoAllowedMan
				   && {[_x] call SFSM_fnc_fipoAvailable}};

// New FIPO found
if(_nearFipos isNotEqualTo [])exitWith{
    private _newFipo  = [_man, _nearFipos] call SFSM_fnc_getNearest;
	[_man, _newFipo, _canMove] spawn SFSM_fnc_moveInFipo;
	[_man, "Moving in to next Fipo"] spawn SFSM_fnc_flashAction;

};

//In case no new FIPO is found then look for a position behind the fipo to run to.
private _backDir     = [((getDir _fipo)-180)] call Tcore_fnc_formatDir;
private _srchPos     = _man getPos [(SFSM_DodgeDistance-30), _backDir];
private _coverPos    = [_man, _srchPos, (SFSM_DodgeDistance/2)] call SFSM_fnc_getCoverPos;
private _coverFound  = (!isNil "_coverPos" && {typeName _coverPos isEqualTo "ARRAY"});

if(_coverFound isEqualTo false)then{ 
	private _avail = [_srchPos, 30, 10] call Tcore_fnc_availablePositions;
	_coverPos      = [_man, _avail] call SFSM_fnc_getNearest;

}else{[_man, "dodging to cover"] call SFSM_fnc_setAction;};


// No new position was found.
if(isNil "_coverPos")exitWith{
	[_man, "none"] call SFSM_fnc_setAction;
	[_man, "Hit and run failed, NOWHERE TO RUN!"] spawn SFSM_fnc_flashAction;
};

//Code to be executed once the move to the new position was completed.
private _endCode = {
	params["_man"];
	[_man, "none"] call SFSM_fnc_setAction;
	[_man, "Hit and run completed"] spawn SFSM_fnc_flashAction;
};

// Move to the new position.
private _postFnc = [[_man], false, _endCode];
private _run     = [_man, _coverPos, 20, 5, nil, _postFnc] spawn SFSM_fnc_forcedMove;

};