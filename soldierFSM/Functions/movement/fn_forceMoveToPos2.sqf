params [
    "_man",                  // the man that will move.
    "_pos",                 //  target position
    ["_maxTime", 30],      //   timeout (max time to attempt to reach said pos)
    ["_maxDistance", 1.3] //    distance to wanted pos before aborting move.
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
private _startTime   = time;
private _timer       = _startTime + _maxTime;
private _distance    = round(_man distance2d _pos);
private _keepMoving  = _distance > _maxDistance;
private _combatMode  = unitCombatMode _man;

[_man] call SFSM_fnc_fixPos;
_man doTarget objNull;
// _man disableAI "FSM";

_man doMove _pos;

while {_keepMoving} do { 
    private _hasMoved = _man distance2D  _startPos > 5;
    private _pronePos = unitPos _man isEqualTo "DOWN";

    _keepMoving = [_man, _pos, _maxDistance, _timer] call SFSM_fnc_keepMoving;
    
    if(_hasMoved &&{_pronePos})then{[_man, "AUTO"] remoteExecCall ["setUnitPos",  _man]};
    if!(_keepMoving)           exitWith{};

    [_man, _startPos, _startTime] call SFSM_fnc_forcedMoveProne;
    
    sleep 0.3;
};


_man enableAI "AUTOTARGET";
_man enableAI "FSM";
_man setUnitCombatMode  _combatMode;

if(SFSM_forceDodge)
then{[_man, true] call Tcore_fnc_toggleAiMoveInhibitors};

_man setAnimSpeedCoef 1;
[_man] call SFSM_fnc_fixPos;

[_man, "forcedMovement",      false] call SFSM_fnc_unitData;
[_man, "hasForcedMoveProned", false] call SFSM_fnc_unitData;

private _moveFailed   = _man distance2D _pos > _maxDistance;

if(_moveFailed)exitWith{ 
    private _noFlash = SFSM_debugger && {(_man getVariable "SFSM_UnitData" get "flashAction") isEqualTo ""};
    if(_noFlash)then{[_man, "''doMove'' retry...", 0.5] spawn SFSM_fnc_flashAction;};
    false;
};

true;