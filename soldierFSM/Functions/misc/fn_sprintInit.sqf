params["_man", "_pos"];
private _distance  = _man distance2D _pos;
private _segments  = _distance / 2.42;		//avg distance of the sprint-anim
private _timeLimit = _segments * 0.621;		//avg time of the sprint-anim
private _timer     = time+_timeLimit;		//when the loop should end if no other conditions are met

//SFSM_sprinters is used to cap the amount of simultaneous sprinters.
SFSM_sprinters pushBackUnique _man;

_man setVariable ["SFSM_Sprinting",true];
_man setVariable ["SFSM_SprintComplete", false];
_man setVariable ["SFSM_maxSegments", _segments];
_man setVariable ["SFSM_SprintTimer", _timer];
_man setVariable ["SFSM_SprintDestination", _pos];
_man setVariable ["SFSM_SprintSegmentsDone", 0];

//return the time-limit so that it can be used in the waitUntil statement.
_timer;