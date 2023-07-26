// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_battleField"];
if(SFSM_hijackVehicles isEqualTo "never")exitWith{};
if(isNil "_battleField")exitWith{"Battlefield is nil"call dbgmsg;};

private _radius = _battleField get "radius";
private _pos = _battleField get "center";
private _vehicles = [_pos, _radius] call SFSM_fnc_availableVehicles;
// _vehicles = _vehicles select {(_x getVariable ["SFSM_allowHijack",false])};

if(_vehicles isEqualTo [])exitWith{"no vehicles available for hijack"call dbgmsg;};

private _units = missionNamespace getVariable (_battleField get "units");
_units = _units select {(([_x, "action"]call SFSM_fnc_unitData)=="none")&&{(typeOf _x)==(typeof (vehicle _x))}};

_units = [_units, _vehicles, SFSM_DodgeDistance] call SFSM_fnc_UnitsNearVehicles;
if(_units isEqualTo [])exitWith{"no near units"call dbgmsg;};

{
    _units = _units select {([_x, "action"]call SFSM_fnc_unitData)=="none"};
    if(_units isEqualTo [])exitWith{"no available units"call dbgmsg;};

    [_x, _units] call SFSM_fnc_hijackVehicle;
    sleep 0.1;
    
} forEach _vehicles;

true;