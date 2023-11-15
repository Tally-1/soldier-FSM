// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man", "_turret"];
private _timer     = time + 35;
private _turretPos = getPosATLVisual _turret;

_turret setVariable ["SFSM_gunner", _man];
[_man, "action", "Getting in turret!"] call SFSM_fnc_unitData;
["mounting_turret", [_man, _turret]]   call CBA_fnc_localEvent;

_man assignAsGunner _turret;
[_man] orderGetIn true;

[
	_man, 
	_turretPos,
	30,
	5
] call SFSM_fnc_forceMove2;

if!([_man, _turret] call SFSM_fnc_canGetInTurret)exitWith{
    [_man, _turret, "Cannot get in"] call SFSM_fnc_failTurretMount;
};

[_man, _turret] call SFSM_fnc_getInTurret;

waitUntil {
    sleep 1;
    private _mounted  = _man in crew _turret;
    private _timedOut = time > _timer;
    
    if(_mounted)  exitWith {true;};
    if(_timedOut) exitWith {true;};

    if  ([_man, _turret] call SFSM_fnc_canGetInTurret)
	then{[_man, _turret] call SFSM_fnc_getInTurret;};

    false;
};

if(_man in crew _turret isEqualTo false)exitWith{
	[_man, _turret, "Wrong gunner"] call SFSM_fnc_failTurretMount;
};

[_man, "action", "Manning turret!"] call SFSM_fnc_unitData;
["turret_mounted", [_man, _turret]] call CBA_fnc_localEvent;

true;