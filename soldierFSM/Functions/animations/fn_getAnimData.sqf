params["_man", "_anim"];

[_man] call SFSM_fnc_fixPos;
private _startPos  = getPosATLVisual _man;
private _animList  = [];
hint "Starting anim-check";
_man setDir 0;
sleep 0.3;

for "_i" from 1 to 15 do {_animList pushBack _anim};

// _man playMoveNow _anim;
private _startTime = time;
private _move      = [_man, _animList, true] spawn SFSM_fnc_playAnimList;

waitUntil { 
	for "_i" from 1 to 12 do {
		sleep 0.1;
		if(scriptDone _move)exitWith{};
		(_man getVariable "speeds")    pushBackUnique (speed _man);
		(_man getVariable "animTimes") pushBackUnique (moveTime _man);
	};
	hint str (time - _startTime);
	scriptDone _move;
};

// [_man] call SFSM_fnc_fixPos;

private _endPos = getPosATLVisual _man;
private _dir    = round(_startPos getDirVisual _endPos);
private _dist   = (_startPos distance _endPos)/count _animList;

private _data = [_anim, _dir, _dist, stance _man];
hint str _dist;
_data deleteAt 0;

sleep 1;
_man switchMove "amovpercmstpsraswrfldnon";
hint "Check complete";
sleep 1;

_man setPos _startPos;
_man setDir 0;



_data;