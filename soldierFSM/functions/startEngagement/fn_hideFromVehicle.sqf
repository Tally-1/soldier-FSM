params["_man", "_hidePos", "_enemyVehicle"];
private _battleKey = [_man, "currentBattle"] call SFSM_fnc_unitData;
private _battleField = SFSM_battles get _battleKey;
if(isNil "_battleField")exitWith{};

private _action = [_man, "action"] call SFSM_fnc_unitData;

if("hunker" in _action)
then{
		private _objectHash = [_man, "hunkObjectHash"] call SFSM_fnc_unitData;
		[_man, _objectHash, "Need to hide from enemy Vehicle"] call SFSM_fnc_endHunker;
	};

        _action = [_man, "action"] call SFSM_fnc_unitData;
private _tempActions = ["dodging", "reacting", "flinch", "healing", "fire"];
private _tempOcupied = [_action, _tempActions] call Tcore_fnc_substringsPresent;
private _timer       = time + 60;


if((! _tempOcupied)
&&{!  (_action == "none")})
exitWith{"cannot break current action, man cannot hide from vehicle" call dbgmsg};


if(_tempOcupied)
then{
		waitUntil 	
		{
			sleep 1;
			_action = [_man, "action"] call SFSM_fnc_unitData;
			private _available   = _action == 'none';
			private _battleEnded = isNil "_battleField";
			private _dead        = !alive _man;

			if(_available)exitWith{true};
			if(_battleEnded)exitWith{true};
			if(_dead)exitWith{true};
			if(time > _timer)exitWith{true};

			false;
		};
	};


if(isNil "_battleField")					exitWith{"cannot hide, battle ended" call dbgmsg};
if([_enemyVehicle]call Tcore_fnc_deadCrew)	exitWith{"won't hide, crew dead" call dbgmsg};
if(!alive _man)					            exitWith{"cannot hide, man died" call dbgmsg};
if(time > _timer)					        exitWith{"cannot hide, timed out" call dbgmsg};

[_man, "action", "Hiding from enemy vehicle"] call SFSM_fnc_unitData;

_timer       = time + SFSM_DodgeTimer;
private _script = [_man, _hidePos, SFSM_DodgeTimer] spawn SFSM_fnc_forceMoveToPos;

waitUntil { scriptDone _script || time > _timer };

[_man, "action", "none"] call SFSM_fnc_unitData;
private _group = group _man;
_man doFollow leader _group;
true;