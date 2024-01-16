params [
	["_captive",        nil, [objNull]],
	["_captor",         nil, [objNull]],
	["_ignoreDistance", false, [false]],
	["_ignoreState",    false, [false]]
];

if!([_captor, true] call SFSM_fnc_canRun)             exitWith{false;};
if!([_captor, _captive] call SFSM_fnc_hostile)        exitWith{false;};
if!(alive _captive)                                   exitWith{false;};
if([_captive, true] call SFSM_fnc_canRun)             exitWith{false;};

if (_ignoreDistance isEqualTo false
&&{_captor distance _captive > 5})  
exitWith{false;};


if (_ignoreState isEqualTo false
&&{[_captive] call SFSM_fnc_canBeCaptured isEqualTo false})  
exitWith{false;};

private _pos       = getPosATL _captive;
private _enemyNear = ([_captor, 50, _pos] call SFSM_fnc_nearEnemies)isNotEqualTo [];

if(_enemyNear)exitWith{
	[_captor, "Enemies near, cannot capture enemy", 1] call SFSM_fnc_flashAction;
	false;
};

true;