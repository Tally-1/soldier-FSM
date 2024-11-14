// Returns an array of positions between a shooter and a target
params[
    ["_shooter",  nil,  [objNull]],
    ["_target",   nil,  [objNull]],
    ["_width",    200,        [0]], // Width (in degrees) of the cone
    ["_maxRange", 300,        [0]], // The max distance between a position and the target
    ["_minRange", 50,         [0]], // The minimum distance between a position and the target
    ["_posCount", 300,        [0]] 
];
private _shooterPos = getPosATL _shooter;
private _targetPos  = getPosATL _target;
private _distance   = (_shooter distance _target)*1.1;
private _posSpread  = round (_distance*0.15);
private _dir        = _target getDir _shooter;
private _minDist    = _minRange+10;

if(_distance < _minDist)  then{_distance = _minDist};
if(_distance > _maxRange) then{_distance = _maxRange};

private _positions = [
    _targetPos,
    _distance,
    _dir,
    _width,
    _minRange,
    _posSpread/*,
    _posCount*/
] call SFSM_fnc_zoneCone;

_positions;