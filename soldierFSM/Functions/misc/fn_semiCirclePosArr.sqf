params [
    ["_zone",         nil,  [[]]], // [pos, rad] (The zone which will be encircled)
    ["_dir",          nil,   [0]], // 0-359 
    ["_dirRange",     nil,   [0]], // 0-360 (default to 180 degrees for a semicircle)
    ["_posToPosDist", nil,   [0]], // 0-inf (the wanted distance between each position)
    ["_maxPosCount",  nil,   [0]] // Maximum number of positions to return
];
_zone params ["_center", "_radius"];

private _circumference = _radius * 2 * 3.14159265358979323846; // Full circle circumference

// Adjust _posToPosDist if _maxPosCount is specified
if (!isNil "_maxPosCount") then {
    private _desiredPosCount = _circumference / _posToPosDist * (_dirRange / 360);
    if (_desiredPosCount > _maxPosCount) then {
        _posToPosDist = _circumference / (_maxPosCount * (360 / _dirRange));
    };
};

private _angleStep = _posToPosDist / _circumference * 360; // Angle step in degrees

// Adjust _angleStep to fit evenly within the specified direction range
if (!isNil "_maxPosCount" && {_angleStep * _maxPosCount < _dirRange}) then {
    _angleStep = _dirRange / _maxPosCount;
};

private _positions = [];
private _dirStart  = [_dir - (_dirRange * 0.5)] call Tcore_fnc_formatDir;

for "_i" from 0 to _dirRange step _angleStep do {
    private _currentDir = [_dirStart + _i] call Tcore_fnc_formatDir;
    private _pos = [_center, _currentDir, _radius] call SFSM_fnc_sinCosPos2;
    _positions pushBack _pos;

    // Break loop if _maxPosCount is reached
    if (!isNil "_maxPosCount" && {count _positions >= _maxPosCount}) exitWith {};
};

_positions;