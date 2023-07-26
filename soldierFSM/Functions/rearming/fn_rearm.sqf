// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man"];

private _canRearm = [_man] call SFSM_fnc_canRearm;
if!(_canRearm)exitWith{};

[_man, "last_AmmoCheck", time] call SFSM_fnc_unitData;


private _battleKey     = [_man, "currentBattle"] call SFSM_fnc_unitData;
private _battlefield   = SFSM_Battles get _battleKey;

private _supplies      = [_man, _battlefield] call SFSM_fnc_battleFieldSupplies;
private _machineguns   = [_man, _battlefield] call  SFSM_fnc_battleFieldMachineGuns;

if(_supplies isEqualTo []
&&{_machineguns isEqualTo []})exitWith{/*"no guns or supplies" call dbgmsg;*/};

private _machineGunner  = [_man] call SFSM_fnc_isMachineGunner;
private _needMachinegun = ((! _machineGunner) && {count _machineguns > 0});

if(_needMachinegun)exitWith{
        private _gun = ([_machineguns, [], { _man distance _x }, "ASCEND"] call BIS_fnc_sortBy)#0;
        [_man, _gun] spawn SFSM_fnc_pickUpWeapon;
    };

private _magCount = [_man] call SFSM_fnc_primaryWeaponMags;
private _needAmmo = (_machineGunner && {_magCount < 1}) || ((! _machineGunner) && {_magCount <= 2});

if(! _needAmmo)exitWith{};

private _supplyObject = [_supplies, _man] call SFSM_fnc_getBestSupply;

if(isNull _supplyObject)exitWith{
    [_man] spawn SFSM_fnc_getNewWeapon;
};

[_man, _supplyObject] spawn SFSM_fnc_rearmAtSupply;

true;