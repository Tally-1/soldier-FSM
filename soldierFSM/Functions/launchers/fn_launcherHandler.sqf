// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man"];

private _handler =
_man addEventHandler ["FiredMan", {
    params ["_man", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_missile", "_vehicle"];
    if(_weapon isNotEqualTo secondaryWeapon _man)exitWith{};
    [_man, _missile] spawn SFSM_fnc_handleForcedMissile;
    _man setVariable ["SFSM_launched", true];
}];

_handler;