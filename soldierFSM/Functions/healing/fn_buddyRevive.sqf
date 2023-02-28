params["_healer", "_unconscious"]; 

//set action-data
private _startPos    = getPos _healer;
private _healerName  = name _healer;
private _woundedName = name _unconscious;
private _wPos        = getPos _unconscious;
_wPos = [_wPos#0, (_wPos#1)+0.7, 0];
private _timeLimit   = 30;

if(_timeLimit < SFSM_DodgeTimer)then{_timeLimit = SFSM_DodgeTimer};

private _timer       = time + _timeLimit;

private _hAction = ["reviving ", _woundedName]joinString "";
private _wAction = ["being revived by ", _healerName]joinString "";

[_healer, "action", _hAction] call SFSM_fnc_unitData;
[_unconscious, "action", _wAction] call SFSM_fnc_unitData;

if([_healer, _wPos] call SFSM_fnc_canSprint)then{
	private _sprint = [_healer, _wPos] spawn SFSM_fnc_sprint;//SFSM_fnc_sprintToPos;
	waitUntil{sleep 1; scriptDone _sprint;};
}else{
	private _run = [_healer, _wPos, _timeLimit, 3] spawn SFSM_fnc_forceMove2;
	waitUntil{ sleep 1; (scriptDone _run || time > _timer);};
};



//check if conditions are still valid, if not then abort revive
private _canHeal = [_healer, _unconscious, true, 7, true] call SFSM_fnc_canBuddyHeal;
if(! _canHeal)exitWith{
	[_healer, _unconscious, false] spawn SFSM_fnc_endBuddyRevive;
};


private _relocatePos = [_healer, _unconscious] call SFSM_fnc_dragPos;

if (!isNil "_relocatePos") then {
	private _timeAdded = round((_unconscious distance2D _relocatePos) * 1.2);
	_timer             = _timer + _timeAdded;
	private _drag      = [_healer, _unconscious, _relocatePos] spawn SFSM_fnc_dragMan;
	
	waitUntil { sleep 1; scriptDone _drag;};
};

if(! _canHeal)exitWith{
	[_healer, _unconscious, false] spawn SFSM_fnc_endBuddyRevive;
};

//revive
private _healing = [_healer, _unconscious] spawn SFSM_fnc_reviveAnim;
waitUntil{
		sleep 1; 
		scriptDone _healing;
};

private _canHeal = [_healer, _unconscious, true, 7] call SFSM_fnc_canBuddyHeal;
if(! _canHeal)exitWith{
		[_healer, _unconscious, false] spawn SFSM_fnc_endBuddyRevive;
};

[_unconscious, false] call ace_medical_fnc_setUnconscious;
[_healer, _unconscious] call ace_medical_treatment_fnc_fullHeal;
[_healer, _unconscious, true] spawn SFSM_fnc_endBuddyRevive;
true;