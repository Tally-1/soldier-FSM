params ["_grenade", "_source"];
private _velocity = velocityModelSpace _grenade;
// sleep 1;
private _timer = time + 4;

waitUntil {
		private _touchingGround = ((getPos _grenade)#2) < 0.1;
		private _stopped = speed  _grenade < 0.1;
		((_touchingGround
		&&{_stopped})
		|| (time > _timer));
	};

private _nearSoldiers = ([_grenade, ([_grenade, 30] call Tcore_fnc_nearSoldiers)] call Tcore_fnc_sortByDist);
if(count _nearSoldiers == 0)exitWith{};

private _nearest      = _nearSoldiers#0;
private _action       = [_nearest, "action"] call SFSM_fnc_unitData;
private _canThrowBack = SFSM_throwBackGrenade 
                      && {(_nearest distance2D _grenade)<7
					  && {!isNil "_action"}};

if(_canThrowBack)
then{
	_nearSoldiers = _nearSoldiers select {_x != _nearest};
	[_nearest, _grenade, _velocity, _source] spawn SFSM_fnc_throwBackGrenade;
	};

if(count _nearSoldiers == 0)exitWith{};

{
	private _action = [_x, "action"] call SFSM_fnc_unitData;
	if(!isNil "_action")then{[_grenade, _x, 30, true] spawn SFSM_fnc_evadeGrenade;};
	
} forEach _nearSoldiers;

true;