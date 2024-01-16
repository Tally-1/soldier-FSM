params[
	["_startPosASL", nil,          [[]]],
	["_endPosASL",   nil,          [[]]],
	["_ignoreObj1",  objNull, [objNull]],
	["_ignoreObj2",  objNull, [objNull]]
];

private _linebreaks = lineIntersectsSurfaces [_startPosASL, _endPosASL, _ignoreObj1, _ignoreObj2, true, 3];

_linebreaks = _linebreaks select {(_x#3) isKindOf "man" isEqualTo false;};

private _broken = _linebreaks isNotEqualTo [];

_broken;