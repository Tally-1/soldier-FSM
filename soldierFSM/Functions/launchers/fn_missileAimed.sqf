params[
    ["_missile", nil, [objNull]],
    ["_target",  nil, [objNull]],
    ["_minDist", 50,        [0]],
    ["_maxDist", 300,       [0]]
];
private _distance = (_missile distance2D _target)*1.1;
if(_distance > _maxDist) exitWith{false;};
if(_distance < _minDist) exitWith{false;};

private _startPos = getPosASLVisual _missile;
private _endPos   = _missile modelToWorldVisualWorld [0,_distance,0];
private _object   = (lineIntersectsSurfaces [_startPos, _endPos, _missile, objNull, true, 3]apply{_x#3})#0;

if(isNil "_object")              exitWith{false;};
if(_object isNotEqualTo _target) exitWith{false;};


true;