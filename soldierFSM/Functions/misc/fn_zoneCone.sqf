params [
    ["_pos",         nil,  [[]]],  // Center position of the zone
    ["_rad",         nil,   [0]],  // Radius of the zone
    ["_dir",         nil,   [0]],  // Direction of cone
    ["_width",       nil,   [0]],  // Width (in degrees) of the cone
    ["_clearRad",    nil,   [0]],  // Radius at which the cone starts
    ["_posDist",     10,    [0]],  // Distance between positions
    ["_maxPosCount", nil,   [0]]   // Max number of positions to return
];

private _positions = []; // Array to store the positions

// Adjust _posDist based on _maxPosCount if specified
if (!isNil "_maxPosCount") then {
            // Estimate the number of positions we would get with the original _posDist
        private _estPosCount = (_rad / _posDist) * (_width / 360) * 2 * 3.14159265358979323846 * (_rad / _posDist);
        
        if (_estPosCount > _maxPosCount) then {
            _posDist = _posDist * sqrt(_estPosCount / _maxPosCount);
        };
};

// Iterate over the radius, generating semicircles with decreasing radii
for "_r" from _rad to 0 step -_posDist do { 
    if(_r < _clearRad) exitWith{};
    if(_r < _posDist)  exitWith{};

    private _conePositions = [[_pos, _r], _dir, _width, _posDist] call SFSM_fnc_semiCirclePosArr;
    private _lastIndex = count _conePositions-1;
    private _first     = _conePositions#0;
    private _last      = _conePositions#_lastIndex;

    _positions append _conePositions;

    // Stop if _maxPosCount is reached
    if (!isNil "_maxPosCount" && {count _positions >= _maxPosCount}) exitWith {
        _positions resize _maxPosCount;
    };
};

_positions;