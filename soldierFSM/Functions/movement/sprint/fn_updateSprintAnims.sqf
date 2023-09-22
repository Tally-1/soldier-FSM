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
private _destination = _man getVariable "SFSM_SprintDestination";


// hint str [[_index+1, (count _animArr)], floor(_man distance _destination)];

private _doUpdate    = [_man] call SFSM_fnc_canUpdateSprintAnims;
if(_doUpdate isEqualTo false)exitWith{false;};

private _distance    = (_man distance _destination)-3;
private _finalAnims  = [_distance] call SFSM_fnc_sprintEndAnims;

if(_finalAnims isEqualTo [])exitWith{false;};

if(SFSM_debugger)then{
	_dbgTxt = str (_finalAnims apply {_x get "name"});
	[_man, _dbgTxt] spawn SFSM_fnc_flashAction;
};


_animArr append (_finalAnims apply {_x get "animName"});

[_man] call SFSM_fnc_fixPos;

true;