params [
    "_man",         
    "_pos",         
    "_maxDistance", 
    "_timer"/*,
	"_startTime"*/
];

if(isNil "_pos")exitWith{false;};

private _keepMoving = true;

isNil{// Forced unscheduled execution
private _distance      = ((eyePos _man) distance2d _pos);
private _close         = _man distance _pos < 3;
private _failed        = moveToFailed _man;
private _completed     = moveToCompleted _man;
private _badCompletion = _completed && {_distance > _maxDistance};


if (_man getVariable ["SFSM_Sprinting", false])       exitwith{_keepMoving = true;};
if ([_man, "abortForcedMove"] call SFSM_fnc_unitData) exitWith{_keepMoving = false};
if (_distance < _maxDistance)                         exitWith{_keepMoving = false};
if (time > _timer)                                    exitWith{_keepMoving = false};
if!([_man, true] call SFSM_fnc_canRun)                exitWith{_keepMoving = false};
if ([_man] call SFSM_fnc_isPlayer)                    exitWith{_keepMoving = false};
// if ([_man, _pos] call SFSM_fnc_canSprint)             exitWith{[_man, _pos] spawn SFSM_fnc_sprint;};


private _target        = getAttackTarget _man;
if(!isNull _target)then{_man doTarget objNull;};


if(_failed
|| _badCompletion
|| _close)
then{
        
        _man doMove _pos;
        _man moveTo _pos;
		_man doTarget objNull;
        _man disableAI "AUTOTARGET";
		if(SFSM_debugger
		&&{[_man, "flashAction"] call SFSM_fnc_unitData isEqualTo "";})
		then{[_man, "forced move repeat", 0.5] spawn SFSM_fnc_flashAction;};
		
};


_man setCombatBehaviour "AWARE";
_man setUnitCombatMode  "WHITE";



};// Unscheduled execution ended.

_keepMoving;