// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3



params["_man", "_pos"];

private _anims     = [_man, _pos] call SFSM_fnc_sprintAnimList;
private _condition = { [_man]     call SFSM_fnc_sprintCondition};
private _midFnc    = { [_man]     call SFSM_fnc_sprintMidFnc};
private _endFnc    = { [_man]     call SFSM_fnc_sprintEndFnc};
private _timeLimit = count _anims * 1;

//start-sprint EH
["sprint_start", [_man, _pos]]   call CBA_fnc_localEvent;

//set dir, disable ai, set speed
_man disableAI "anim";
_man setAnimSpeedCoef SFSM_sprintSpeed;
_man doMove [_pos#0,_pos#1, 0];
_man setDir (_man getDir _pos);
_man setUnitPos "AUTO";
_man setVariable ["SFSM_SprintDestination", _pos];
_man setVariable ["SFSM_Sprinting",         true];

[
	_man, 
	_anims, 
	true, 
	_condition,
	_midFnc, 
	_endFnc, 
	_timeLimit,
	true

] call  SFSM_fnc_playAnimList;

true;


/* OLD FUNCTION (May be completely removed if the new one is problem-free):
params["_man", "_pos"];
_man doMove [_pos#0,_pos#1, 0];

//set variables and get time-limit
private _timer = [_man, _pos] call SFSM_fnc_sprintInit;
private _startTime = time;

//start-sprint EH
["sprint_start", [_man, _pos]]   call CBA_fnc_localEvent;

//set dir, disable ai, set speed
_man disableAI "anim";
_man setAnimSpeedCoef SFSM_sprintSpeed;
// _man setDestination [_pos, "DoNotPlanFormation", true];
_man setDir (_man getDir _pos);

//looping eventhandler
[_man] call SFSM_fnc_sprintLooper;

//start running
[_man, "AmovPercMevaSrasWrflDf"] remoteExecCall ["playMoveNow", 0];
sleep 1;

//wait for conditions to exit loop
waitUntil {
    
    sleep 0.5;
    private _timeSinceStart = time - _startTime;
    private _ended = (_man getVariable ["SFSM_SprintComplete", false]) || time > _timer;
    if(_ended)exitWith{true};

    if(_timeSinceStart < 3
    &&{_man distance2D _pos > 15 })
    then{_man setDir (_man getDir _pos);};
    
    // if(speed _man < 15)then{_man setPosASL ([getPosASL _man, 0.2] call Tcore_fnc_addZ)};
    false;
};


//check that variables was deleted
private _sprintVar = _man getVariable "SFSM_Sprinting";
if(!isNil "_sprintVar")then{[_man] call SFSM_fnc_sprintVarRemoval;};


//delete last variable and reenable ai.
_man setAnimSpeedCoef 1;
_man setVariable ["SFSM_SprintComplete", nil];

// _man disableAI "path";
// private _pos = getPos _man;
// for "_i" from 1 to 5 do{ 
// if(_pos distance2D _man > 1)then{_man setPos _pos;};
// sleep 0.01;
// };

// _man enableAI "path";
_man enableAI "anim";
true;

*/