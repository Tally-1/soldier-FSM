params[
    ["_position", nil,      [[]]],
    ["_target",   nil, [objNull]]
];
if(_position distance2D _target < 20)exitWith{false};

private _shootingPos = ATLToASL (_position vectorAdd [0,0,1.1]);
private _targetPos   = eyePos _target;
private _vectorPos   = [_shootingPos, _targetPos, 10] call SFSM_fnc_posOnVector;
private _linebreaks  = [_shootingPos, _vectorPos, [_target]] call SFSM_fnc_validSurfaceIntersections;
private _valid       = _linebreaks isEqualTo [];
if(!_valid)exitWith{false};

private _visible = ([objNull, "VIEW", _target] checkVisibility [_shootingPos, _vectorPos])isEqualTo 1;
if(!_visible)exitWith{false};

true;