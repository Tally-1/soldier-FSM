params["_man", "_turret"];
private _timer = time + 2;
private _manPos    = getpos _man;
private _distance  = (_man distance2D _turret)-1;
private _dir       = _man getDir _turret;
private _moveToPos = [_manPos#0, _manPos#1, _dir, _distance] call Tcore_fnc_sinCosPos;

_turret setVariable ["SFSM_gunner", _man];
[_man, "action", "Getting in turret!"] call SFSM_fnc_unitData;


if(_distance > 4)then{

	_man setAnimSpeedCoef SFSM_sprintSpeed;
	private _move = [_man, _moveToPos] spawn SFSM_fnc_forceMove2;
	_timer = _timer + 30;
	_man setAnimSpeedCoef 1;

};

waitUntil { 
	sleep 0.3;
	[_man, _turret, _timer] call SFSM_fnc_turretRunEnded;
 };

if!([_man, _turret] call SFSM_fnc_canGetInTurret)exitWith{[_man, _turret] call SFSM_fnc_failTurretMount;};

[_man, _turret] call SFSM_fnc_getInTurret;

sleep 1;
if(gunner _turret != _man)exitWith{[_man, _turret] call SFSM_fnc_failTurretMount;};

[_man, "action", "Manning turret!"] call SFSM_fnc_unitData;
true;