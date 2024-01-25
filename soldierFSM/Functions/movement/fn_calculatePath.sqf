// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _timeLimit = 30;
params["_man", "_destination", "_timeLimit"];

private _start = getPos _man;
private _timer = time + _timeLimit;
private _agent = (calculatePath ["man", (behaviour _man), _start, _destination]);

_agent setVariable ["SFSM_pathOwner", _man];

[_agent] call SFSM_fnc_PathCalculated;
private _path = _man getVariable "SFSM_currentPath";

waitUntil {
    sleep 0.1;
    _path = _man getVariable "SFSM_currentPath";
    (!isNil "_path") || (_timer < time);
 };

// if(isNull _agent)exitWith{};

if(isNil "_path")exitWith{deleteVehicle _agent;};

private _nPath = [];
{_nPath pushBackUnique ASLToATL _x;} forEach _path;

_man setVariable ["SFSM_currentPath", _nPath]; 

deleteVehicle _agent;

true;