// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_vehicle", "_units"];
private _filter = {((_vehicle distance _x) < SFSM_DodgeDistance)
                &&{[_x, "action"]call SFSM_fnc_unitData == "none"
                &&{[_x, "pathEnabeled"]call SFSM_fnc_unitData
                &&{(!(_x getVariable ["SFSM_Excluded",false]))
                &&{typeOf _x == typeOf (vehicle _x)
                &&{!(_x in allPlayers)}}}}}};

_units = ([_units, [], {_vehicle distance _x }, "ASCEND"] call BIS_fnc_sortBy);
_units = _units select _filter;

if(_units isEqualTo [])exitWith{};

["vehicle_hijack", [_vehicle, _units]] call CBA_fnc_localEvent;

[_vehicle, (_units#0)] spawn SFSM_fnc_getInVehicle;

if(count _units == 1)exitWith{};

[_vehicle, (_units#1), "driver"] spawn SFSM_fnc_getInVehicle;


true;