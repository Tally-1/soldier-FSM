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
private _animCount      = count _animArr;
private _iCount         = _index+1;
private _remainingAnims = _animCount-_iCount;
// Exit if there is more than 1 anim left.
// 1 Anim has a distance of 2.42m (depending on a variety of factors)
if(_remainingAnims > 1) 
exitWith{false;};

// Exit if there is less than 1m left after the last anim has played (3 - 2.42 = 0.58).
private _destination = _man getVariable "SFSM_SprintDestination";
if(_man distance2D _destination < 1.7)
exitWith{false;};

//Exit if the anim-list has been updated.
private _updatesCompleted = _man getVariable ["SFSM_SprintAnimUpdates", false];
if(_updatesCompleted isEqualTo true)
exitWith{false;};

_man setVariable ["SFSM_SprintAnimUpdates", true];

true;