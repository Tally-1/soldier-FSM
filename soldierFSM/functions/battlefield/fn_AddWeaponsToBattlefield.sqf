// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: This script is called when a unit dies. It will add all weapons that are close to the unit to the battlefield-data.

// Params: _man (Object) - the unit that died

// Return value: true(boolean)

// Example: [_deadMan] call SFSM_fnc_addWeaponsToBattlefield;


params ["_man"];
sleep 1;
private _battleKey = [_man, "currentBattle"] call SFSM_fnc_unitData;
private _battlefield = SFSM_Battles get _battleKey;

if(isNil "_battlefield")exitWith{};

private _droppedWeapons = nearestObjects [_man, ["WeaponHolder", "WeaponHolderSimulated"], 5];

private _weaponCount    = count _droppedWeapons;

if(_weaponCount == 0)exitWith{["could not find weapons close to dead man", 2] call dbgmsg};

private _weaponsVar = (_battlefield get "weapons");

{
    (missionNamespace getVariable _weaponsVar) pushBackUnique _X;
    _x setVariable ["SFSM_weaponOwner", _man];
} forEach _droppedWeapons;



private _finalCount = count (missionNamespace getVariable _weaponsVar);

[[
    _weaponCount, 
    " weapons were added to battlefield-data. ",
    _finalCount,
    " weapons cached"
]] call dbgmsg;



true;