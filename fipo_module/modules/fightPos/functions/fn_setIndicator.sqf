params[
    ["_indicator",        nil, [objNull]],
    ["_animData",         nil,      [[]]],
    ["_unitPos",          nil,    ["",0]],
    ["_isCoverIndicator", nil,   [false]]
];

private _lastEntry = _animData#(count _animData-1);
private _sideStep  = ((typeName _lastEntry) isEqualTo "STRING") &&{"step" in _lastEntry};
    
if(_sideStep)then{_animData = FIPO_sideStepAnimData get _unitPos};

private _offSet    = _animData#3;
private _animation = _animData#0;
private _leftLean  = typeName _lastEntry isEqualTo "STRING" && {"left"  in _lastEntry};
private _rightLean = typeName _lastEntry isEqualTo "STRING" && {"right" in _lastEntry};
private _leaning   = _leftLean || {_rightLean};

if(_leaning) then{_aslPos = _fipo modelToWorldVisualWorld [_offSet,0,0]};
if(_leftLean)then{_aslPos = _fipo modelToWorldVisualWorld [0-_offSet,0,0]};

// private _ATLpos   = ASLToATL _aslPos;
private _pos      = ASLToAGL _aslPos;
private _altitude = _pos#2;

if(_altitude < 0)then{_pos = [_pos#0, _pos#1, 0];};

_indicator switchMove _animation;
_indicator setPos     _pos;
_indicator setDir (getDir _fipo);

//Give a different color to the cover-stance-indicator
if(_isCoverIndicator)then{[_indicator] call FIPO_fnc_setIndicatorDark;};

true;