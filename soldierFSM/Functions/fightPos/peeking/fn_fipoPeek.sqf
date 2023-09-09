params["_man"];
private _peekTime = ([_man] call SFSM_fnc_fipoPeekTime)+0.1;//added 0.1 to account for the wait 
private _coolDown = [_man] call SFSM_fnc_peekCoolDownTime;
private _stances  = [_man] call SFSM_fnc_fipoStanceIndexes;

if(isNil "_stances")exitWith{};

private _coverStance    = _stances#0;
private _shootUp        = _stances#1;
private _shootRight     = _stances#2;
private _shootLeft      = _stances#3;
private _fireStances    = [_shootUp, _shootRight, _shootLeft];
private _shootingStance = [_fireStances] call SFSM_fnc_selectShootingStance;

if(isNil "_shootingStance")exitWith{"No stance found" call dbgmsg;};

if(_coverStance isEqualTo _shootingStance)exitwith{
    [_man, "No stance-change in fipo"] spawn SFSM_fnc_flashAction;
};

private _timer = time + 1.2;

// Get out of "safe" stances
private _anim = _man getVariable "SFSM_idleAnim";
if!(isNil "_anim")then{
    [_man] call SFSM_fnc_abortIdleFipo;
};

//change to peeking(high) stance.
[_man, "Peeking"] call SFSM_fnc_setAction;
[_man, _shootingStance] call SFSM_fnc_animSetStance;

//wait for stance to complete.
waitUntil{((_man getVariable ["SFSM_animStanceDone", false]) || (time > _timer))};

//Look for and engage enemies.
// private _peek = 
[_man, _peekTime] call SFSM_fnc_peekActions;
// waitUntil {scriptDone _peek;};

//exit script if man has left  the fighting position
if!([_man, "inFipo"] call SFSM_fnc_unitData)exitWith{};

//change to cover(low) stance.
[_man, _coverStance] call SFSM_fnc_animSetStance;

//wait for stance to complete.
_timer    = time+1.2;
_man attachTo [([_man] call SFSM_fnc_getFipo), [0,0,0]];
waitUntil{((_man getVariable ["SFSM_animStanceDone", false]) || (time > _timer))};
detach _man;

//define action and cooldown
[_man, "In cover"] call SFSM_fnc_setAction;
[_man, "peekCooldown", (time+_coolDown)] call SFSM_fnc_unitData;


// Sometimes ACE-medical messes things up, this fixes it.
private _noFipo = !([_man] call SFSM_fnc_inFipo);

if(_noFipo && {[_man] call SFSM_fnc_isUncon})exitWith{
    [_man, "none"] call SFSM_fnc_setAction;
};

if([_man] call SFSM_fnc_isUncon)then{
    [_man] call SFSM_fnc_getOutFipo
};


true;