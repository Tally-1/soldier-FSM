private _shots 	 = 1;
private _maxTime = 3;
private _rps 	 = 7;//rounds pr second default
params[
		"_shooter", 
		"_target", 
		"_maxTime",
		"_weapon",
		"_shots",
		"_rps"		
	  ];

if(isNil "_weapon")then{_weapon = currentWeapon _shooter};

private _sleep 		= _rps / 1;
private _aimTime	= (_shots / _maxTime) - _sleep;
private _endTime 	= time + _maxTime;

_shooter doWatch  	_target;
_shooter doTarget 	_target;
_shooter doFire		_target;

for "_i" from 1 to _shots 
do {		
		private _timer = time + _aimTime;
		private _timedOut = false;

		waitUntil { 
					private _onTarget = [_shooter, _target] call SFSM_fnc_unitAimedAtTarget;
					_timedOut = time > _timer;
					
					if(_onTarget)exitwith{_shooter forceWeaponFire [_weapon, "single"]; true};
					if(_timedOut)exitwith{_shooter doWatch  _target; true};
					sleep 0.02;
					false
				  };
		if(_timedOut)then{_shooter doFire _target};
		
		_shooter doWatch  _target;
		sleep _sleep;
		if(time > _endTime)exitWith{};
	};

_shooter doWatch  objNull;
_shooter doTarget objNull;
// _shooter doFire   _target;
// _shooter fireAtTarget [_target, _gLauncher];
// _shooter doWatch  _target;
// _shooter doTarget _target;
true;