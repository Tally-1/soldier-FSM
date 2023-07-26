// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man"];
private _explosives = [_man] call SFSM_fnc_carriedExplosives;
if(count _explosives <1)exitWith{[]};
_explosives sort false;
private _explosive = _explosives#0;
private _charge = [_explosive] call SFSM_fnc_formatExplosiveName;

[
    _explosive, // inventoryName
    _charge     // cfgName
];