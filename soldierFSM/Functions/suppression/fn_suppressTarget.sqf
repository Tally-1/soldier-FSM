/*
    Sets one man to suppress another.
    SFSM_fnc_getSuppressionTarget will be used if desired, the "getSuppressionTarget" is heavy so only use if necesary
    [man_1, enemy_1, true] spawn SFSM_fnc_suppressTarget;
*/
params[
    ["_shooter", nil,    [objNull]], // the man who will suppress the enemy 
    ["_target",  nil, [objNull,[]]], // the enemy (Man or position) who will be suppressed 
    ["_find",    nil,           []]  // If set to true an algorythm will be called to find the best position to suppress at (shoot at)
];
private _suppressTarget = _target;
private _timer          = time+4;

_shooter setVariable ["SFSM_suppressing", true, true];

if(_find)then{
    _suppressTarget = [_shooter, _target, false]call SFSM_fnc_getSuppressionTarget
};

if(isNil "_suppressTarget")then{
    [_shooter, "Suppress-Target not found"] spawn SFSM_fnc_flashAction;
    _suppressTarget = _target;
};

["suppressing_now", [_shooter,_suppressTarget]] call CBA_fnc_localEvent;

[_shooter] call SFSM_fnc_stand;

waitUntil{
    private _standing = _shooter getVariable ["SFSM_standing", false];
    if(_standing)  exitWith{true};
    if(time>_timer)exitWith{true};
    false;
};

_shooter doSuppressiveFire _suppressTarget;

sleep 2;

waitUntil {sleep 1;	currentCommand _shooter != "Suppress"};

_shooter setUnitPos "AUTO";

_shooter setVariable ["SFSM_suppressing", false, true];

true;