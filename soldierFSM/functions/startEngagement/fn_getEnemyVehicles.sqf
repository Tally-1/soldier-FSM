// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man", "_battlefield"];

private _vehicles = missionNamespace getVariable (_battlefield get "vehicles");

if((count _vehicles) == 0)exitWith{[]};

private _side           = side _man;
private _enemyVehicles  = [];


{
    private _thisSide = side _x;
    private _enemy    = !([_Side, _thisSide] call BIS_fnc_sideIsFriendly);
    private _crewAlive= ! ([_x] call Tcore_fnc_deadCrew);

    if(_enemy
    &&{_crewAlive
    &&{!(_thisSide == civilian)}})
    then{_enemyVehicles pushBack _x};

} forEach _vehicles;

_enemyVehicles;