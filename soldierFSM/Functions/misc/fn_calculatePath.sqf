private _timeLimit = 30;
params["_man", "_destination", "_timeLimit"];

private _start = getPos _man;
private _timer = time + _timeLimit;
private _agent = (calculatePath ["man", "AWARE", _start, _destination]);

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