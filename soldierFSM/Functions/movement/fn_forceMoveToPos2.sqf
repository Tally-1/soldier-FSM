params [
    "_man",                  // the man that will move.
    "_pos",                 //  target position
    ["_maxTime", 30],      //   timeout (max time to attempt to reach said pos)
    ["_maxDistance", 1.3],//    distance to wanted pos before aborting move.
    "_spamTimer",        //     here for legacy reasons
    "_postFnc"          //      function to be run on completion [[params], _isScheduled, _code]
];
private _canSprint = [_man, _pos, 50, 5] call SFSM_fnc_canSprint;

_pos = [_pos] call SFSM_fnc_formatMovePos;

if(_canSprint)exitWith{
    [_man, _pos] call SFSM_fnc_sprint;
    
    //repeated twice here because sometimes the sprint does not reach all the way.
    _canSprint = [_man, _pos, 30, 10] call SFSM_fnc_canSprint;

    if(_canSprint isEqualTo false)exitWith{};
	[_man, _pos] call SFSM_fnc_sprint;
};

if(SFSM_forceDodge)
then{[_man, false] call Tcore_fnc_toggleAiMoveInhibitors};

_man setAnimSpeedCoef SFSM_sprintSpeed;
[_man, "forcedMovement", true] call SFSM_fnc_unitData;

private _startPos    = getPosATLVisual _man;
private _timer       = time + _maxTime;
private _distance    = round(_man distance2d _pos);
private _keepMoving  = _distance > _maxDistance;
private _combatMode  = unitCombatMode _man;

[_man] call SFSM_fnc_fixPos;
_man doTarget objNull;
_man disableAI "FSM";

_man doMove _pos;
_man moveTo _pos;

while {_keepMoving} do {
	_keepMoving = [_man, _pos, _maxDistance, _timer] call SFSM_fnc_keepMoving;
    sleep 0.3;
};


_man enableAI "AUTOTARGET";
_man enableAI "FSM";
_man setUnitCombatMode  _combatMode;

if(SFSM_forceDodge)
then{[_man, true] call Tcore_fnc_toggleAiMoveInhibitors};

_man setAnimSpeedCoef 1;
[_man, "forcedMovement", false] call SFSM_fnc_unitData;
[_man] call SFSM_fnc_fixPos;

//reset brain if man did not move.
// if(_startPos distance (getPosATLVisual _man) < 2)
// then{[_man] call SFSM_fnc_resetBrain;};

if(_man distance2D _pos > _maxDistance
&&{SFSM_debugger
&&{[_man, "flashAction"] call SFSM_fnc_unitData isEqualTo "";}})
then{[_man, "forced move failed"] spawn SFSM_fnc_flashAction;};

true;