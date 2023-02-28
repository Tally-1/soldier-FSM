private _time = 1;
params["_man", "_flashText", "_time"];

private _flashActions = [
	"Path calculated", 
	"Sprinting!!", 
	"Calculating path", 
	"Turret-mount failed!"
	];


private _action = [_man, "action"] call SFSM_fnc_unitData;

if(isNil "_action")         exitWith{};
if(_action in _flashActions)exitWith{};

[_man, "action", _flashText] call SFSM_fnc_unitData;

sleep _time; 
[_man, "action", _action] call SFSM_fnc_unitData;

true;