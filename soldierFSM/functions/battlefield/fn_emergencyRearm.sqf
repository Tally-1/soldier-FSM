//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Attempts to send a unit to pick up a weapon from the battlefield. 
// Params: [_man:object]
// Return value: boolean - true if the unit was sent to pick up a weapon, false otherwise.
// Example: [_man] call SFSM_fnc_emergencyRearm;

params ["_man"];

if!(SFSM_emergencyRearm)exitWith{false};

private _battleKey   = [_man, "currentBattle"] call SFSM_fnc_unitData;
if(isNil "_battleKey")exitwith{false;};

private _battleField =  SFSM_Battles get _battleKey;
if(isNil "_battleField")exitWith{false;};

private _launcher = secondaryWeapon _man;
if!(_launcher == "")exitWith{false;};

private _weapon     = [_man, _battleField] call SFSM_fnc_getBattlefieldWeapon;

if(isNil "_weapon")exitWith{false;};

[_man, _weapon] spawn SFSM_fnc_pickUpWeapon;

true;