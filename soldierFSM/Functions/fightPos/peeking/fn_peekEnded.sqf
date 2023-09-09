params["_man", "_timeLimit"];
if(time > _timeLimit)exitWith{true;};

private _recentIncomingFire = time - ([_man, "Last_Close_Bullet"] call SFSM_fnc_unitData)< 0.2;
private _recentHitByBullet  = time - ([_man, "Last_Hit"] call SFSM_fnc_unitData)< 0.2;

if(isNil "_recentIncomingFire") then{_recentIncomingFire = false;};
if(isNil "_recentHitByBullet")  then{_recentHitByBullet  = false;};

if(_recentIncomingFire)exitWith{true;};
if(_recentHitByBullet) exitWith{true;};

false;