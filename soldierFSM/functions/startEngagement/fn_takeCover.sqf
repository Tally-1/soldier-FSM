params ['_man', '_coverPos'];
if(isNil '_coverPos')exitWith{'cover-pos is nil' call SFSM_fnc_debugMessage};

private _timer  = time + 5;
private _available = [_man, _timer] call SFSM_fnc_manAvailable;

if!(_available)
then{
		waitUntil { 
					sleep 0.1;
					[_man, _timer] call SFSM_fnc_manAvailable;
				  };
	};

_available = [_man, (time + 5)] call SFSM_fnc_manAvailable;

if!(_available)exitWith{'unit too busy to take cover' call SFSM_fnc_debugMessage};

private _target	   = getAttackTarget _man;
private _behaviour = behaviour _man;
private _timer     = time + SFSM_DodgeTimer;

if(SFSM_forceDodge)
then{
		_man disableAI "TARGET";
		_man disableAI "AUTOCOMBAT";
		_man disableAI "AUTOTARGET";
		_man doTarget objNull;
		if(stance _man == "prone")then{_man setUnitPos "MIDDLE"};
	};

[_man, "action", "taking cover"]	call SFSM_fnc_unitData;

_man moveTo _coverPos;
_man doMove _coverPos;

[_man, _coverPos, _timer, _target, _behaviour] spawn SFSM_fnc_endTakeCover;