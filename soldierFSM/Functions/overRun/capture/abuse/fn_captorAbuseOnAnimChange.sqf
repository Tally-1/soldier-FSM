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
private _victim     = _man getVariable "SFSM_myExecVictim";
private _anchor     = _man getVariable "SFSM_myAnchor";
private _nextAnim   = _animArr#(_index+1);

if(_man distance _anchor > 1)then{
	_man     attachTo [_anchor, [0,0,0]];
	_victim  attachTo [_anchor, [0,0,0]];

	[_man, _victim] spawn{
		sleep 0.1; 
		detach (_this#0);
		detach (_this#1);
	};
};

if(_nextAnim isEqualTo "acts_executioner_kill")then{
	[_man, _victim] spawn SFSM_fnc_executionerKillshot;
};

true;