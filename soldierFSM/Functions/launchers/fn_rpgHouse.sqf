params[
    ["_man",      nil, [objNull]],
    ["_building", nil, [objNull]],
    ["_repeat",   true,  [false]],
    ["_delayShot",false, [false]]
];

private _launchPos   = [_man, _building] call SFSM_fnc_getRpgLaunchPos;


if(isNil "_launchPos")exitWith{[_man, "RPG on house failed, could not find launchpos"] call SFSM_fnc_flashAction;};


[_man, _building, _launchPos] call SFSM_fnc_initRpgHouse;
[_man]                        call SFSM_fnc_loadLauncherHE;
[_man, _building, _launchPos] call SFSM_fnc_moveToRpgLaunchPos;

private _cannotMove = ([_man, true] call SFSM_fnc_canRun) isEqualTo false;
if(_cannotMove)exitWith{[_man, false] call SFSM_fnc_endRpgHouse;};

private _canShoot = [_man, _building] call SFSM_fnc_atValidRpgFirePos &&{[_man, _building] call SFSM_fnc_clearHouseImpactPos};
private _tryAgain = _repeat isEqualTo true && {_canShoot isEqualTo false};

if (_tryAgain)exitWith{ 
    [_man, "Could not fire RPG, trying again!"] spawn SFSM_fnc_flashAction;
    [_man, _building, false] call SFSM_fnc_rpgHouse;
};

if!(_canShoot)exitWith{[_man, false]  call SFSM_fnc_endRpgHouse;};

if(_delayShot)then{
   _man disableAI "PATH";
   _man disableAI "MOVE";
   sleep 3;
   _man enableAI "PATH";
   _man enableAI "MOVE";
};

private _hasFired = [_man, _building] call SFSM_fnc_fireLauncherAtHouse;
private _tryAgain = _repeat isEqualTo true && {_hasFired isEqualTo false};

if (_tryAgain)exitWith{ 
    [_man, "RPG failed launch, trying again!"] spawn SFSM_fnc_flashAction;
    [_man, _building, false, true] call SFSM_fnc_rpgHouse;
};

[_man, _hasFired] call SFSM_fnc_endRpgHouse;

true;