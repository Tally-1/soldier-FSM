// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3
params [
	["_agent", nil,[objNull]],
    ["_path",  nil,     [[]]]
];
_agent removeEventHandler [_thisEvent, _thisEventHandler]; 
private _man        = _agent getVariable "SFSM_pathOwner";
private _newPath    = [];
private _count      = count _path;

// short paths do not need filtering.
if(_count < 4)exitWith{_man setVariable ["SFSM_currentPath", (_path apply {ASLToATL _x})]};

private _lastIndex  = _count-1;
private _longPath   = _count > 15;
private _shortDist  = (_path#0)distance(_path#_lastIndex) < 30;
private _skipFilter = _longPath || {_shortDist};

// Intended to skip filtering when outdoors
if(_skipFilter)
exitWith{_man setVariable ["SFSM_currentPath", (_path apply {ASLToATL _x})]};


for "_i"from 0 to _lastIndex do {
    private _pos       = ASLToATL (_path#_i);
	private _canFilter = (_i!=0)&&{_i!=_lastIndex};
	
	if(_canFilter)then{
		private _prevPos  = ASLToATL (_path#(_i-1));
		private _distance = _pos distance _prevPos;
		if(_distance > 5)then{_newPath pushBackUnique _pos};
	}else{
		_newPath pushBackUnique _pos;
	};
};

_man setVariable ["SFSM_currentPath", _newPath];

// deleteVehicle _agent;

true;
