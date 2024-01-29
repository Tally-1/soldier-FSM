params[
	["_thrower",nil, [objNull]], 
	["_target", nil, [objNull]] 
];
private _targetPos = getPosATLVisual _target;
private _throwDir  = [_thrower, _targetPos] call SFSM_fnc_getSmokeDeployDir;

[_thrower, _throwDir] call SFSM_fnc_deploySmoke;

true;