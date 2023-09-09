// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_battlefield"];
private _center   = _battlefield get "center";
private _radius   = _battlefield get "radius";
private _groups   = missionNamespace getVariable   (_battlefield get "groups");
private _vehicles = _center nearEntities ["staticWeapon", _radius];

if(isNil "_vehicles") exitWith{};
if(isNil "_groups")   exitWith{};

if(_vehicles isEqualTo []) exitWith{};
if(_groups isEqualTo [])   exitWith{};

[_vehicles, _groups] call SFSM_fnc_getTurretsAndLeaders 
params ["_turrets", "_leaders"];

if(_turrets isEqualTo [])  exitWith{};
if(_leaders isEqualTo [])  exitWith{};

{
    [_x, _turrets] call SFSM_fnc_assignTurret;
    sleep 0.3;
} forEach _leaders;