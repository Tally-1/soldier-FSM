params[ 
    ["_startPosASL", nil, [[]]], // Man or vehicle whos LOS is evaluated.
    ["_endPosASL",   nil, [[]]], // The target being queried.
    ["_ignoreList",  nil, [[]]]
];
if(_ignoreList isEqualTo [])
then{_ignoreList = [objNull,objNull]};

if(count _ignoreList isEqualTo 1)
then{_ignoreList set [1,objNull]};

private _linebreaks = lineIntersectsSurfaces [_startPosASL, _endPosASL, (_ignoreList#0), (_ignoreList#1), true, 5];

_linebreaks = _linebreaks select { 
    private _object     = _x#3;
    private _notMan     = (_object isKindOf "man")isEqualTo false;
    private _notIgnored = (_object in _ignoreList)isEqualTo false;
    private _valid      = (_notMan  && {_notIgnored})||{isNull _object};
    
    _valid;
};

_linebreaks;