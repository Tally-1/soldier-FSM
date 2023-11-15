params [
	"_man", 
	"_anim"
]; 
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
_anim = toLowerANSI _anim;
private _wantedAnim = _animArr#_index;
private _continue   = [_man] call _condition; //Must return bool
private _completed  = _index isEqualTo ((count _animArr)-1);
private _timedOut   = time > _timer;
private _abort      = isNil "_animArr";
private _extAbort   = _man getVariable ["SFSM_animListAborted", false];
private _canMove    = [_man, true] call SFSM_fnc_canRun;
private _ignoreWrongAnim = _man getVariable "SFSM_ignoreWrongAnim";

if(_extAbort  isEqualTo true)  exitWith{true;};
if(_abort     isEqualTo true)  exitWith{true;};
if(_completed isEqualTo true)  exitWith{true;};
if(_timedOut  isEqualTo true)  exitWith{true;};
if(_continue  isEqualTo false) exitWith{true;};
if(_canMove   isEqualTo false) exitWith{true;};

[_man] call _midFnc;

_continue = [_man] call _condition;

if(_continue  isEqualTo false) exitWith{true;};


if(_anim in _wantedAnim)then{
    _index = _index+1;
	private _nextAnim = _animArr#_index;
	
	[_man, _nextAnim] remoteExecCall ["playMoveNow", _man];

}else{
if(_ignoreWrongAnim)exitWith{
	_index = _index+1;
	private _nextAnim = _animArr#_index;
	[_man, _nextAnim] remoteExecCall ["playMoveNow", _man];
};

if(time - _startTime > 1.5)then{
	"Wrong anim played" call dbgmsg;
	
	[[_anim, " |!-!| ", _wantedAnim],1] call dbgmsg;
	
	[_man, "Wrong anim, Failed list"] spawn SFSM_fnc_flashAction;
	
	_abort = true;
}};

if(_abort isEqualTo true)exitWith{true;};

private _prms = [_animArr, _waitForCompletion, _condition, _midFnc, _postFnc, _index, _startTime, _timer, _eh];

// private _actionTxt = ["AnimList #", _index]joinString"";
// [_man, _actionTxt, 0.5] spawn SFSM_fnc_flashAction;

_man setVariable ["SFSM_animListParams", _prms];

false;