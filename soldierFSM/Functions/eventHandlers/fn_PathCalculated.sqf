params["_agent"];
private _currentPath = _agent getVariable "SFSM_currentPath";

if(!isNil "_currentPath")then{_agent setVariable ["SFSM_currentPath", nil, true];};

private _eh =
_agent addEventHandler ["PathCalculated", {
	params ["_agent", "_path"];

	private _man = _agent getVariable "SFSM_pathOwner";

	_man setVariable ["SFSM_currentPath", _path];
	_agent removeEventHandler [_thisEvent, _thisEventHandler]; 
}];

_eh;