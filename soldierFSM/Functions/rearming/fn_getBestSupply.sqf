// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_supplies", "_man"];
private _validSupplies  = _supplies select {([(primaryWeapon _man), _x] call SFSM_fnc_hasMagsForWeapon)>0;};
if(_validSupplies isEqualTo [])exitWith{objNull};
if(count _validSupplies == 1)  exitWith{(_validSupplies#0)};

//Select the nearest supplypoint.
private _best = ([_validSupplies, [], { _man distance _x }, "ASCEND"] call BIS_fnc_sortBy)#0;

_best;