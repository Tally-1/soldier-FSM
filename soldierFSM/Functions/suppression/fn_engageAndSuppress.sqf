params[
    ["_shooter", nil,    [objNull]], // the man who will suppress the enemy 
    ["_target",  nil,    [objNull]], // the enemy (Man or position) who will be suppressed
    ["_action",  nil,         [""]]
];
private _suppressTarget = [_shooter, _target, false]call SFSM_fnc_getSuppressionTarget;
private _setAction      = {params["_shooter","_target","_action"]; if(!isNil "_action")then{[_shooter, _action] call SFSM_fnc_setAction}};
private _removeAction   = {params["_shooter","_target","_action"]; if(!isNil "_action")then{[_shooter, "none"]  call SFSM_fnc_setAction}};

if(!isNil "_suppressTarget")exitWith{
    _this call _setAction;

    [_shooter, _suppressTarget, false] call SFSM_fnc_suppressTarget;

    _this call _removeAction;
};

// Find fireposition
(_this call SFSM_fnc_getSuppressFirePosTarget)
params[
    ["_movePos",   nil,         [[]]], // the man who will suppress the enemy 
    ["_targetPos", nil, [objNull,[]]]  // the enemy (Man or position) who will be suppressed
];
if(isNil "_movePos")
exitWith{[_shooter, "No suppress-pos found"] spawn SFSM_fnc_flashAction};

private _timeLimit = round((_shooter distance2D _movePos)*2);

_this call _setAction;

["engage_suppress", [_shooter,_target]] call CBA_fnc_localEvent;
[_shooter, _movePos, _timeLimit]        call SFSM_fnc_forcedMove;
[_shooter, _target, true]               call SFSM_fnc_suppressTarget;

_this call _removeAction;

true;