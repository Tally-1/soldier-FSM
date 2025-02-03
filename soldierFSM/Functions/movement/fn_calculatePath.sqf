// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3
params[
    ["_man",         nil,[objNull]],
    ["_destination", nil,     [[]]],
    ["_timeLimit",    10,       [0]]
];
private _agent     = objNull;
private _start     = getPos _man;
private _distance  = _start distance _destination;
private _timer     = time + _timeLimit;
private _behaviour = behaviour _man;

// No need to calculate a path on minor distances
if(_distance < 10)               exitwith{};
if(_behaviour isEqualTo "ERROR") exitwith{};


// make sure no frames pass until eventhandlers and variables are in place
isNil{
    _agent     = (calculatePath ["man", _behaviour, _start, _destination]);
	_agent addEventHandler ["PathCalculated", SFSM_fnc_pathCalculated];
    _agent setVariable ["SFSM_pathOwner", _man];
	_man   setVariable ["SFSM_currentPath",nil];
};

// retrieve _path if possible.
private _path = _man getVariable "SFSM_currentPath";
waitUntil {
    _path = _man getVariable "SFSM_currentPath";
    (!isNil "_path") || (_timer < time);
};

// private _deleteAgent = { if((!isNull _agent)&&{local _agent&&{!isDedicated}})then{deleteVehicle _agent};nil};


if(isNil "_path")exitWith{};// _deleteAgent;

// call _deleteAgent;

_path;