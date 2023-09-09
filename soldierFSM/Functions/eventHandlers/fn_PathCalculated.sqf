// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_agent"];
if(isNull _agent)exitWith{};

private _currentPath = _agent getVariable "SFSM_currentPath";

if(!isNil "_currentPath")then{_agent setVariable ["SFSM_currentPath", nil, true];};

_agent addEventHandler ["Deleted", {
        _agent removeEventHandler [_thisEvent, _thisEventHandler]; 
}];

_agent addEventHandler ["PathCalculated", {
    params ["_agent", "_path"];
    private _man = _agent getVariable "SFSM_pathOwner";

    _man setVariable ["SFSM_currentPath", _path];
    _agent removeEventHandler [_thisEvent, _thisEventHandler]; 
}];

