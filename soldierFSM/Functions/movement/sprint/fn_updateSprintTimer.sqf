params["_man"];
(_man getVariable "SFSM_animListParams")
params [
	"_animArr", 
	"_waitForCompletion", 
	"_condition", 
	"_midFnc", 
	"_postFnc", 
	"_index", 
	"_startTime", 
	"_timer", 
	"_eh"
];

if(time < _timer)exitWith{};

_timer = _timer + 2;

private _params = [
	_animArr,
	_waitForCompletion,
	_condition,
	_midFnc,
	_postFnc,
	_index,
	_startTime,
	_timer,
	_eh	
];

_man setVariable ["SFSM_animListParams", _params];

true;