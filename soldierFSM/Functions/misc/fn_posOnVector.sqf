params[
    ["_startPos", nil, [[]]], // Start of the original vector
    ["_endPos",   nil, [[]]], // End of the original vector
    ["_distToPos", nil, [0]]  // How far into the vector you wish to retrieve a position
];

private _dir      = _startPos getDir _endPos;
private _distance = _startPos distance _endPos;
private _distCoef = _distToPos / _distance; // Calculate distance coefficient

private _offset = [
    (_endPos select 0) - (_startPos select 0),
    (_endPos select 1) - (_startPos select 1),
    (_endPos select 2) - (_startPos select 2)
] vectorMultiply _distCoef;

private _newPos = _startPos vectorAdd _offset;

_newPos;