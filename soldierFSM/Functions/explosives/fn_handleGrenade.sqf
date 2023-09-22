params ["_grenade", "_source"];
private _velocity = velocityModelSpace _grenade;

private _timer = time + 4;

waitUntil {
        private _touchingGround = ((getPos _grenade)#2) < 0.1;
        private _stopped = speed  _grenade < 0.1;
        ((_touchingGround
        &&{_stopped})
        || (time > _timer));
    };

private _nearSoldiers = [_grenade, (_grenade nearEntities 15 select {
	[_x] call SFSM_fnc_canRun
	&&{([_x] call SFSM_fnc_isPlayer) isEqualTo false}
	})] call Tcore_fnc_sortByDist;

if(count _nearSoldiers == 0)exitWith{};

private _nearest      = _nearSoldiers#0;
private _canThrowBack = SFSM_throwBackGrenade 
                      && {(_nearest distance2D _grenade)<7};

if(_canThrowBack)
then{
    _nearSoldiers = _nearSoldiers select {_x != _nearest};
    [_nearest, _grenade, _velocity, _source] spawn SFSM_fnc_throwBackGrenade;
    ["grenade_throwback", [_nearest, _grenade]] call CBA_fnc_localEvent;
    };

if(count _nearSoldiers isEqualTo 0)exitWith{};

{
    private _action = [_x, "action"] call SFSM_fnc_unitData;
    if(!isNil "_action")then{[_grenade, _x, 30, true] spawn SFSM_fnc_evadeGrenade;};
    
} forEach _nearSoldiers;

true;