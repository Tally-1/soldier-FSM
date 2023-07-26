params["_man"];
if((behaviour _man) isEqualTo "STEALTH")exitWith{false;};

private _battle   = [_man] call SFSM_fnc_getBattlefield;
private _fighting = (!isNil "_battle") || ((behaviour _man) isEqualTo "COMBAT");
if(_fighting)exitWith{false;};

private _anim = _man getVariable "SFSM_idleAnim";
if!(isNil "_anim")exitWith{false;};


private _lastBullet = [_man, "Last_Close_Bullet"] call SFSM_fnc_unitData;
private _lastShot   = [_man, "last_bullet_fired"] call SFSM_fnc_unitData;
private _lastAction = selectMax [_lastBullet, _lastShot];

private _timeSinceLast = time - _lastAction;
if(_timeSinceLast < 60)exitWith{false;};


true;