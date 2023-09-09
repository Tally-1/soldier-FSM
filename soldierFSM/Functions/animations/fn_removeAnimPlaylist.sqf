params["_man"];
private _prms  = _man getVariable "SFSM_animListParams";
private _doneVar  = _man getVariable "SFSM_animListDone";

if(isNil "_prms")exitWith{false;};

_prms
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

if(!isNil "_eh")then{_man removeEventHandler ["AnimDone", _eh];};
_man setVariable ["SFSM_animListParams",  nil];
_man setVariable ["SFSM_animListAborted", nil];
_man setVariable ["SFSM_animListDone",    nil];

if(isNil "_waitForCompletion" isEqualTo false
&&{isNil "_doneVar"           isEqualTo false
&&{_waitForCompletion         isEqualTo true }})then{
	_man setVariable ["SFSM_animListDone", true];
};

true;