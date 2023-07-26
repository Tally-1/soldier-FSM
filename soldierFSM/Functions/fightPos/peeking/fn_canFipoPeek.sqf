params["_man"];
if!([_man] call SFSM_fnc_inFipo)exitWith{false;};

private _action = [_man] call SFSM_fnc_getAction;
if("In cover" != _action
&&{"Idle"     != _action})exitWith{false;};

private _cooldown = [_man, "peekCooldown"] call SFSM_fnc_unitData;
if(time < _cooldown)exitWith{false;};

private _suppression = getSuppression _man;
if(_suppression > 0.5)exitWith{false;};

// man will do peeking behaviour, if in stealth-mode, even if he is not in combat.
if((behaviour _man) isEqualTo "STEALTH")exitWith{true;};

// cannot peek if not in combat and not in stealth.
private _battle   = [_man] call SFSM_fnc_getBattlefield;
private _fighting = (!isNil "_battle") || ((behaviour _man) isEqualTo "COMBAT");
if!(_fighting)exitWith{false;};

private _usingLauncher = currentWeapon _man isEqualTo secondaryWeapon _man;
if(_usingLauncher)exitWith{false;};

true;