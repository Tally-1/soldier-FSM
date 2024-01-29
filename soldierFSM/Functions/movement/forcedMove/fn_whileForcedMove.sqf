params[
    ["_man",        nil, [objNull]],
    ["_combatMode", nil,      [""]]
];
private _startPos    = getPosATLVisual _man;
private _startTime   = time;
private _timer       = _startTime + _maxTime;
private _distance    = round(_man distance2d _pos);
private _keepMoving  = _distance > _maxDistance;

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

true;