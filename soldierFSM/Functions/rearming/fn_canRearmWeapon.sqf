// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_weapon", "_supplies"];
private _canRearm = false;
private _weaponType = getWeaponCargo _weapon#0#0;

if(isNil "_weaponType")exitWith{false;};

{
    _canRearm = ([_weaponType, _x] call SFSM_fnc_hasMagsForWeapon)>1;//true;
    if(_canRearm)exitWith{_canRearm = true;};
    
} forEach _supplies;

_canRearm;