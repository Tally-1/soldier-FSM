// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man", "_turret"];
private _timer = time + 2;
private _manPos    = getpos _man;
private _distance  = (_man distance2D _turret)-1;
private _dir       = _man getDir _turret;
private _moveToPos = [_manPos#0, _manPos#1, _dir, _distance] call Tcore_fnc_sinCosPos;

_turret setVariable ["SFSM_gunner", _man];
[_man, "action", "Getting in turret!"] call SFSM_fnc_unitData;
["mounting_turret", [_man, _turret]]   call CBA_fnc_localEvent;

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
private _timer = time + 5;

if!([_man, _turret] call SFSM_fnc_canGetInTurret)exitWith{[_man, _turret, "Cannot get in"] call SFSM_fnc_failTurretMount;};

[_man, _turret] call SFSM_fnc_getInTurret;

waitUntil {
    sleep 1;
    private _mounted  = _man in crew _turret;
    private _timedOut = time > _timer;
    
    if(_mounted)  exitWith {true;};
    if(_timedOut) exitWith {true;};

    private _canGetIn = [_man, _turret] call SFSM_fnc_canGetInTurret;
    if(_canGetIn)then{_man moveInGunner _turret;};

    false;
};

if(_man in crew _turret isEqualTo false)exitWith{[_man, _turret, "Wrong gunner"] call SFSM_fnc_failTurretMount;};

[_man, "action", "Manning turret!"] call SFSM_fnc_unitData;
["turret_mounted", [_man, _turret]]   call CBA_fnc_localEvent;
true;