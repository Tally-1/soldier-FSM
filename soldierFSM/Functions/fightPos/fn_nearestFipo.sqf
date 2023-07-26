private _radius = 1000;
private _availableOnly = true;
params["_pos", "_radius", "_availableOnly"];
private _fiPositions   = SFSM_fipositions select {_x distance2D _pos < _radius};

if(_availableOnly)then{
    _fiPositions = _fiPositions select {[_x]call SFSM_fnc_fipoAvailable;};
};

if(_fiPositions isEqualTo [])exitWith{};

private _nearest = [_pos, _fiPositions]  call SFSM_fnc_getNearest;

_nearest;