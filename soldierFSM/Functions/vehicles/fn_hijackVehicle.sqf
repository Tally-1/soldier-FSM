// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_vehicle", "_units", "_excluded"];
private ["_count"];

isNil{//Forced unscheduled execution

private _filter =  {(_x in _excluded) isEqualTo false
                && {[_x, _vehicle] call SFSM_fnc_canHijackVehicle
				&& {[_x] call SFSM_fnc_availableAiSoldier}}};

_units = _units select _filter;
_count = count _units;
if(_count isEqualTo 0)exitWith{};

_units = ([_units, [], {_vehicle distance _x }, "ASCEND"] call BIS_fnc_sortBy);


["vehicle_hijack", [_vehicle, _units]] call CBA_fnc_localEvent;

[_vehicle, (_units#0)] spawn SFSM_fnc_getInVehicle;

if(_count isEqualTo 1)exitWith{};

[_vehicle, (_units#1), "driver"] spawn SFSM_fnc_getInVehicle;

};//Forced unscheduled execution ended.

if(_count isEqualTo 0) exitWith {[]};
if(_count isEqualTo 1) exitWith {[(_units#0)]};

[(_units#0), (_units#1)];