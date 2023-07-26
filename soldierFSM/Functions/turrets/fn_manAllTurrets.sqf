// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_vehicles", "_groups"];
if(_vehicles isEqualTo []) exitWith{};
if(_groups isEqualTo [])   exitWith{};

private _TnL = [_vehicles, _groups] call SFSM_fnc_getTurretsAndLeaders;
private _turrets = _TnL#0;
private _leaders = _TnL#1;

if(_turrets isEqualTo [])  exitWith{};
if(_leaders isEqualTo [])  exitWith{};

{
    [_x, _turrets] call SFSM_fnc_assignTurret;
    sleep 0.3;
} forEach _leaders;