params[
    "_man", 
    "_animArr",                     //list of animations to play one after the other.
    ["_waitForCompletion", false], // If true and called in scheduled environment the function will suspend until the sequence has completed.
    ["_condition",        {true}],//  If false the animation-sequence will be aborted
    ["_midFnc",           {}],   //   Code to call between each Animation
    ["_postFnc",          {}],  //    Code to call on completion
	["_timeLimit",        30], //     time-limit until the function is forced to terminate
	["_ignoreWrongAnim",  false]
];

[_man] call SFSM_fnc_removeAnimPlaylist;
[_man, "playingAnimList", true] call SFSM_fnc_unitData;

_animArr = _animArr apply {toLowerANSI _x};

private _prms    = [_animArr, _waitForCompletion, _condition, _midFnc, _postFnc, 0, time];

_man setVariable ["SFSM_animListParams", _prms];
_man setVariable ["SFSM_ignoreWrongAnim", _ignoreWrongAnim];

private _firstMove = _animArr#0;
private _timer     = time + _timeLimit;
private _eh        = [_man] call SFSM_fnc_animListEh;

(_man getVariable "SFSM_animListParams") pushBack _timer;
(_man getVariable "SFSM_animListParams") pushBack _eh;

if(isNil "_firstMove")exitWith{"Error: Animlist first anim not found" call dbgmsg;};

[_man, _firstMove] remoteExecCall ["playMoveNow", _man];

if(_waitForCompletion isEqualTo false)exitWith{};
if(canSuspend         isEqualTo false)exitWith{[["Anim-list wait called in unscheduled environment"], 2] call dbgmsg;};

private ["_completed", "_aborted"];

waitUntil {
    _completed = _man getVariable ["SFSM_animListDone",    false];
	_aborted   = _man getVariable ["SFSM_animListAborted", false];
	
	if(_completed)    exitWith{true;};
	if(_aborted)      exitWith{true;};
	if(time > _timer) exitWith{true;};

	false;
};

private _params = _man getVariable "SFSM_animListParams";

if(_aborted)then{
	_man switchMove "AmovPercMstpSrasWrflDnon";
	_man setVariable ["SFSM_animListAborted", nil];
};

if(!isNil "_params")then{isNil{
	[_man] call SFSM_fnc_animListEnd;
	[_man] call SFSM_fnc_removeAnimPlaylist;
}};


_man setVariable ["SFSM_animListDone", nil];

true;