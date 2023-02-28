params["_man", "_pos"];
_man doMove [_pos#0,_pos#1, 0];

//set variables and get time-limit
private _timer = [_man, _pos] call SFSM_fnc_sprintInit;

//set dir, disable ai, set speed
_man disableAI "anim";
_man setAnimSpeedCoef SFSM_sprintSpeed;
_man setDestination [_pos, "DoNotPlanFormation", true];
_man setDir (_man getDir _pos);

//looping eventhandler
[_man] call SFSM_fnc_sprintLooper;

//start running
[_man, "AmovPercMevaSrasWrflDf"] remoteExecCall ["playMoveNow", 0];

//wait for conditions to exit loop
waitUntil {sleep 0.5; (_man getVariable ["SFSM_SprintComplete", false]) || time > _timer;};


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