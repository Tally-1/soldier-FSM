// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man"];
private _timer  = time + 5;
private _available = [_man, _timer] call SFSM_fnc_manAvailable;

if!(_available)then{
    waitUntil { 
    sleep 0.1;
    [_man, _timer] call SFSM_fnc_manAvailable;
}};