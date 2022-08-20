params ["_man",  "_objectHash", "_battlefield"];
private _action 	= + [_man, "action"] call SFSM_fnc_unitData;
private _lastIn 	= + [_man, "Last_Close_Bullet"] call SFSM_fnc_unitData;
private _statusData = _objectHash get "status";
private _canShoot   = _statusData get "canShoot";
private _needHeal   = _statusData get "needHeal";
private _canHeal    = [_man] call SFSM_fnc_canSelfHeal;
private _maxDistance = (_battlefield get "radius")*2;



if(_canHeal
&&{_needHeal})
then{	
		[_man, _action] spawn SFSM_fnc_proneHeal;
		private _timer = time + 20;
		waitUntil {
					sleep 1; 
					if(([_man, "action"] call SFSM_fnc_unitData) == _action)exitWith{true};
					if(time > _timer)exitWith{true};
					false;
					};
	};

If!(_canShoot)exitWith{[_man, "action", "displace from hunker-pos, cannot reach enemy"] call SFSM_fnc_unitData};

if(time - _lastIn < 3)exitWith{[_man, "action", "wait and hunker down, just recieved fire"] call SFSM_fnc_unitData};

private _enemies = [_man, _maxDistance, 'enemies']call Tcore_fnc_nearKnownEnemies;
If(count _enemies < 1)exitWith{[_man, "action", "end hunkering, no enemies"] call SFSM_fnc_unitData};

private _nearest      = [_man, _enemies] call Tcore_fnc_nearestPos;
if(typeName _nearest == "SCALAR")exitWith{[_man, "action", "end hunkering, no enemies"] call SFSM_fnc_unitData};


private _nearDistance = _man distance2D _nearest;
if(_nearDistance <= 70)exitWith{[_man, "action", "displace, enemy close to hunker-pos"] call SFSM_fnc_unitData};

private _target = [_man, _enemies, true] call Tcore_fnc_getLosTarget;
if(isNull _target)exitWith{[_man, "action", "wait, cannot aquire target from hunker-pos"] call SFSM_fnc_unitData};

[_man, "action", "fire at target from hunker-pos"] call SFSM_fnc_unitData;

private _timer = time + 3;
_man setUnitPos "UP";
waitUntil {sleep 1; ((stance _man) ==  "STAND") or (time > _timer)};
sleep 1;
_man doSuppressiveFire _target;
sleep 1;
waitUntil {sleep 0.5; !(currentCommand _man == "Suppress")};

_enemies = [_man, _maxDistance, 'enemies']call Tcore_fnc_nearKnownEnemies;
_target  = [_man, _enemies, true] call Tcore_fnc_getLosTarget;
if!(isNull _target)
then{
		for "_i" from 1 to 10 do
		{
			_enemies = [_man, _maxDistance, 'enemies']call Tcore_fnc_nearKnownEnemies;
			_target  = [_man, _enemies, true] call Tcore_fnc_getLosTarget;

			if(alive _target)
			then{_man doFire _target; sleep 0.3};

		};
		sleep 2;
	};



_man setUnitPos "DOWN";

sleep 2;

if((damage _man) > 0.25)then{_man action ["HealSoldierSelf", _man]};

[_man, "action", "fired! Now hunker down"] call SFSM_fnc_unitData;