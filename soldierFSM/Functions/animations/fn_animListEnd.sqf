params ["_man"];
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

if(_waitForCompletion)then{
    _man setVariable ["SFSM_animListDone", true];
};

[] call _postFnc;

_man setVariable ["SFSM_animListParams",  []];
_man setVariable ["SFSM_animListParams",  nil];
_man setVariable ["SFSM_ignoreWrongAnim", nil];
[_man, "playingAnimList", false] call SFSM_fnc_unitData;

[_man] call SFSM_fnc_removeAnimPlaylist;
[_man] call SFSM_fnc_fixPos;

true;