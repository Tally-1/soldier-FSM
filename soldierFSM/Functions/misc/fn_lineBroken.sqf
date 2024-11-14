params[
	["_startPosASL", nil,          [[]]],
	["_endPosASL",   nil,          [[]]],
    ["_ignoreList",  [],           [[]]]
];

private _count  = count _ignoreList;
private _needed = 2-_count;
if(_needed > 0)
then{
    for"_i"from 1 to _needed do
    {_ignoreList pushBack objNull}
};

private _linebreaks = lineIntersectsSurfaces [_startPosASL, _endPosASL, (_ignoreList#0), (_ignoreList#1), true, 5];

// Select objects that are not men, nor in the ignoreList
_linebreaks = _linebreaks select { 
    private _object         = _x#3;
    private _isMan          = _object isKindOf "man";// isEqualTo false;
    private _ignored        = _object in _ignoreList;
    private _validLineBreak = (_isMan isEqualTo false && {_ignored isEqualTo false})||{isNull _object};
    
    _validLineBreak;
};

private _broken = _linebreaks isNotEqualTo [];

_broken;